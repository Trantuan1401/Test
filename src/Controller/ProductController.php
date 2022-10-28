<?php

namespace App\Controller;

use App\Entity\Product;
use App\Form\ProductType;
use App\Repository\AppUserRepository;
use App\Repository\CategoryRepository;
use App\Repository\ProductRepository;
use Doctrine\ORM\Tools\Pagination\Paginator;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Psr\Log\LoggerInterface;


/**
 * @Route("/product")
 */
class ProductController extends AbstractController
{
    /**
     * @Route("/listing/{pageId}", name="app_product_index", methods={"GET"})
     */
    public function index(Request $request, ProductRepository $productRepository, CategoryRepository $categoryRepository, int $pageId = 1): Response
    {   
        
        $minPrice = $request->query->get('minPrice');
        $maxPrice = $request->query->get('maxPrice');
        $cat = $request->query->get('category');
        $word = $request->query->get('word');
        
        $tempQuery = $productRepository->findMore($minPrice, $maxPrice, $cat, $word);
        $pageSize = 6;
        $paginator = new Paginator($tempQuery);
        $totalItems = count($paginator);

        $numberOfPages = ceil($totalItems / $pageSize);

        $tempQuery = $paginator->getQuery()->setFirstResult($pageSize * ($pageId - 1))->setMaxResults($pageSize);
        $products = $tempQuery->getResult();

            return $this->render('product/index.html.twig', [
                'products' => $products,
                'cat' => $cat,
                'categories' => $categoryRepository->findAll(),
                'numOfPages' => $numberOfPages,
            ]);
        
    }

        /**
    * @Route("/reviewCart", name="app_review_cart", methods={"GET"})
    */
    public function reviewCart(Request $request): Response
    {
        $session = $request->getSession();
        if ($session->has('cartElements')) {
            $cartElements = $session->get('cartElements');
        } else
            $cartElements = [];
        return $this->json($cartElements);
    }

    /**
     * @Route("/new", name="app_product_new", methods={"GET", "POST"})
     */
    public function new(Request $request, ProductRepository $productRepository): Response
    {   
        
        $product = new Product();
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);
        $checkUser = $this->isGranted('ROLE_SELLER');
        if (!$checkUser)
        {
            return $this->redirectToRoute('app_login', [], Response::HTTP_SEE_OTHER);
        }        
        

        if ($form->isSubmitted() && $form->isValid()) {
            /** @var \App\Entity\User $user */
            $user = $this->getUser();
            $product->setPublisher($user);
            $productImage = $form->get('Image')->getData();
            if ($productImage) {
                $originExt = pathinfo($productImage->getClientOriginalName(), PATHINFO_EXTENSION);
                $productRepository->add($product, true);
                $newFilename = $product->getId() . '.' . $originExt;

                try {
                    $productImage->move(
                        $this->getParameter('product_directory'),
                        $newFilename
                    );
                } catch (FileException $e) {
                }
                $product->setImgurl($newFilename);
            $productRepository->add($product, true);

            return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);
        
            }
        }
        return $this->renderForm('product/new.html.twig', [
            'product' => $product,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_product_show", methods={"GET"})
     */
    public function show(Product $product): Response
    {
        return $this->render('product/show.html.twig', [
            'product' => $product,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_product_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Product $product, ProductRepository $productRepository): Response
    {   
        $checkUser = $this->isGranted('ROLE_SELLER');
        /** @var \App\Entity\User $user */
        $user = $this->getUser();
        if (!($checkUser && $user->getId() == $product->getPublisher()->getId()))
        {
            return $this->redirectToRoute('app_login', [], Response::HTTP_SEE_OTHER);
        }
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);
        
        if ($form->isSubmitted() && $form->isValid()) {
            $productImage = $form->get('Image')->getData();
            if ($productImage) {
                $originExt = pathinfo($productImage->getClientOriginalName(), PATHINFO_EXTENSION);
                $productRepository->add($product, true);
                $newFilename = $product->getId() . '.' . $originExt;

                try {
                    $productImage->move(
                        $this->getParameter('product_directory'),
                        $newFilename
                    );
                } catch (FileException $e) {
                }
                $product->setImgurl($newFilename);
            $productRepository->add($product, true);

            return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);
        
            }
        }

        return $this->renderForm('product/edit.html.twig', [
            'product' => $product,
            'form' => $form
        ]);
    }


    /**
     * @Route("/{id}", name="app_product_delete", methods={"POST"})
     */
    public function delete(Request $request, Product $product, ProductRepository $productRepository): Response
    {   
        $this->denyAccessUnlessGranted('ROLE_SELLER');
        if ($this->isCsrfTokenValid('delete' . $product->getId(), $request->request->get('_token'))) {
            $productRepository->remove($product, true);
        }

        return $this->redirectToRoute('app_product_index', [], Response::HTTP_SEE_OTHER);
    }
    // private function filterRequestQuery($minPrice, $maxPrice, $cat)
    // {
    //     return [
    //         is_numeric($minPrice) ? (float) $minPrice : NULL,
    //         is_numeric($maxPrice) ? (float) $maxPrice : NULL,
    //         is_numeric($cat) ? (float) $cat : NULL
    //     ];
    // }
    


    /**
    * @Route("/addCart/{id}", name="app_add_cart", methods={"GET"})
    */
    public function addCart(Product $product, Request $request)
    {
        $session = $request->getSession();
        $quantity = (int)$request->query->get('quantity');

        //check if cart is empty
        if (!$session->has('cartElements')) {
            //if it is empty, create an array of pairs (prod Id & quantity) to store first cart element.
            $cartElements = array($product->getId() => $quantity);
            //save the array to the session for the first time.
            $session->set('cartElements', $cartElements);
        } else {
            $cartElements = $session->get('cartElements');
            //Add new product after the first time. (would UPDATE new quantity for added product)
            $cartElements = array($product->getId() => $quantity) + $cartElements;
            //Re-save cart Elements back to session again (after update/append new product to shopping cart)
            $session->set('cartElements', $cartElements);
        }
        return new Response(); //means 200, successful
    }
 

}
