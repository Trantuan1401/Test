<?php

namespace App\Controller;

use Doctrine\ORM\Tools\Pagination\Paginator;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Psr\Log\LoggerInterface;

class IndexController extends AbstractController
{
    /**
         * @Route ("/", name="app_index")
    */
    public function index(Request $request): Response
    {
        return $this->render('index.html.twig', [
        ]);
    }
}

?>