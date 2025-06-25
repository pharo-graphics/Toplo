Trait {
	#name : #TToItemBarOwner,
	#instVars : [
		'itemBar'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'t - item bar owner' }
TToItemBarOwner >> initializeAsItemBarOwner [

	self setItemBar: self newItemBar
]

{ #category : #'t - item bar owner' }
TToItemBarOwner >> itemBar [

	^ itemBar
]

{ #category : #'t - item bar owner' }
TToItemBarOwner >> setItemBar: anItemBar [

	itemBar ifNotNil: [ BlImmutableObjectChangeError signal ].
	itemBar := anItemBar 
]
