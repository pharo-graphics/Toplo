Trait {
	#name : #TToItemBarOwner,
	#instVars : [
		'itemBar'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #initialization }
TToItemBarOwner >> initializeAsItemBarOwner [

	self setItemBar: self newItemBar
]

{ #category : #accessing }
TToItemBarOwner >> itemBar [

	^ itemBar
]

{ #category : #initialization }
TToItemBarOwner >> setItemBar: anItemBar [

	itemBar ifNotNil: [ BlImmutableObjectChangeError signal ].
	itemBar := anItemBar 
]
