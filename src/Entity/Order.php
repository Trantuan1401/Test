<?php

namespace App\Entity;

use App\Repository\OrderRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=OrderRepository::class)
 * @ORM\Table(name="`order`")
 */
class Order
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=User::class, inversedBy="orders")
     */
    private $User;

    /**
     * @ORM\Column(type="datetime")
     */
    private $PurchaseDate;



    /**
     * @ORM\OneToMany(targetEntity=OrderDetail::class, mappedBy="Orders")
     */
    private $OrderDetail;

    /**
     * @ORM\Column(type="float", nullable=true)
     */
    private $Total;

    public function __construct()
    {
        $this->OrderDetail = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUser(): ?User
    {
        return $this->User;
    }

    public function setUser(?User $User): self
    {
        $this->User = $User;

        return $this;
    }

    public function getPurchaseDate(): ?\DateTimeInterface
    {
        return $this->PurchaseDate;
    }

    public function setPurchaseDate(\DateTimeInterface $PurchaseDate): self
    {
        $this->PurchaseDate = $PurchaseDate;

        return $this;
    }


    /**
     * @return Collection<int, OrderDetail>
     */
    public function getOrderDetail(): Collection
    {
        return $this->OrderDetail;
    }

    public function addOrderDetail(OrderDetail $orderDetail): self
    {
        if (!$this->OrderDetail->contains($orderDetail)) {
            $this->OrderDetail[] = $orderDetail;
            $orderDetail->setOrders($this);
        }

        return $this;
    }

    public function removeOrderDetail(OrderDetail $orderDetail): self
    {
        if ($this->OrderDetail->removeElement($orderDetail)) {
            // set the owning side to null (unless already changed)
            if ($orderDetail->getOrders() === $this) {
                $orderDetail->setOrders(null);
            }
        }

        return $this;
    }

    public function getTotal(): ?float
    {
        return $this->Total;
    }

    public function setTotal(?float $Total): self
    {
        $this->Total = $Total;

        return $this;
    }
}
