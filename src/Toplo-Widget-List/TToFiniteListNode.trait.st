"
I'm a list whose all the nodes are computed up front one for each item in the data source.
The scrolling is based on `ToScrollableElement`.

This is by opposition to infintie whose nodes are only computed for visible ones.
The scrolling of infinite elements is managed by the layout.
"
Trait {
	#name : #TToFiniteListNode,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - bar node' }
TToFiniteListNode >> removeFromBar [

	self holder removeNodeFromBar 
]
