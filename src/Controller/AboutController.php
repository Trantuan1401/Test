<?php

namespace App\Controller;

use Doctrine\ORM\Tools\Pagination\Paginator;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Psr\Log\LoggerInterface;

class AboutController extends AbstractController
{
    /**
         * @Route ("/about", name="app_about_us")
    */
    public function about(Request $request): Response
    {
        return $this->render('about.html.twig', [
        ]);
    }
}   

?>