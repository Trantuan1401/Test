<?php

namespace App\Entity;

use App\Repository\CartRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=CartRepository::class)
 */
class Cart
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $Payment;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $Status;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getPayment(): ?string
    {
        return $this->Payment;
    }

    public function setPayment(string $Payment): self
    {
        $this->Payment = $Payment;

        return $this;
    }

    public function getStatus(): ?string
    {
        return $this->Status;
    }

    public function setStatus(string $Status): self
    {
        $this->Status = $Status;

        return $this;
    }
}
