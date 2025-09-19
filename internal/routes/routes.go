package routes

import (
	"github.com/gin-gonic/gin"
	"orders.go/m/internal/controller/orders"
	"orders.go/m/internal/controller/portfolio"
	orders2 "orders.go/m/internal/usecases/orders"
)

func NewPortfolioRoutes(
	router *gin.Engine,
	createOrderUseCase *orders2.CreateOrderUseCase,
) {
	orderController := portfolio.New(createOrderUseCase)

	ordersRoutes := router.Group("/orders")
	{
		ordersRoutes.POST("/", orderController.Create)
	}
}
