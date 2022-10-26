<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class IndexController extends AbstractController
{
    /**
         * @Route ("/", name="app_index")
    */
    public function index(): Response
    {
        /** @var \App\Entity\User $user */
        $user = $this->getUser();
        if($user)
        {
            $product = $user->getProducts();
            return $this->render('index.html.twig', [
            'products' => $product,
        ]);
        }
        else return $this->render('index.html.twig', [
            'products' => [],]);
    }
}

?>