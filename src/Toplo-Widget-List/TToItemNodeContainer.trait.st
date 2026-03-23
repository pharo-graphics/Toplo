Trait {
	#name : #TToItemNodeContainer,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - item node container' }
TToItemNodeContainer >> hasSubitems [

	^ self item hasItems
]

{ #category : #'t - item node container' }
TToItemNodeContainer >> item [ 

	^ self node item
]
