import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: state.items.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final item = state.items[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(item.product.thumbnail, width: 56, height: 56, fit: BoxFit.cover),
                ),
                title: Text(item.product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text('\$${item.product.discountedPrice.toStringAsFixed(2)} each'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => context
                          .read<CartBloc>()
                          .add(CartQuantityChanged(item.product.id, item.quantity - 1)),
                    ),
                    Text('${item.quantity}'),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => context
                          .read<CartBloc>()
                          .add(CartQuantityChanged(item.product.id, item.quantity + 1)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () =>
                          context.read<CartBloc>().add(CartItemRemoved(item.product.id)),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) return const SizedBox.shrink();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 18)),
                      Text('\$${state.total.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(CartCleared());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Order placed! (demo only)')),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text('Checkout'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
