# Swift data structures

I could not find a good Swift implementation of some essential data structures, so I made them. Hope this saves you some time.

Data structures:

- [Queue](https://en.wikipedia.org/wiki/Queue_(abstract_data_type)
- [Stack](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)
- [Circular array](https://en.wikipedia.org/wiki/Circular_buffer)
- [Linked list](https://en.wikipedia.org/wiki/Linked_list)


## A note on linked lists

TL;DR: use (circular) arrays instead of linked lists unless you know what you’re doing.

You may often read the benefits of linked lists from a theoretical point of view, argued using Big-O performance. However, too frequently the [locality of reference](https://en.wikipedia.org/wiki/Locality_of_reference) is not taken into account. Arrays are extremely optimised for traveling and copying, whereas linked lists are much slower for that matter. Even for large datasets, inserting a new element in the middle of the structure may be faster using an array (which requires copying the entire array) than using a linked list (which requires traveling it). However, in some specific cases, a linked list may be just the most performant structure to use.
