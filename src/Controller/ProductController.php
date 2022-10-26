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
     * @Route("/new", name="app_product_new", methods={"GET", "POST"})
     */
    public function new(Request $request, ProductRepository $productRepository): Response
    {   
        $this->denyAccessUnlessGranted('ROLE_SELLER');
        $product = new Product();
        $form = $this->createForm(ProductType::class, $product);
        $form->handleRequest($request);
        
        

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
}
