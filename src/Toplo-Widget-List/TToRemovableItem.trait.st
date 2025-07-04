Trait {
	#name : #TToRemovableItem,
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - removable item' }
TToRemovableItem >> isRemovable [

	^ removable ifNil: [ false ]
]

{ #category : #'t - removable item' }
TToRemovableItem >> removable: aBoolean [

	removable = aBoolean ifTrue: [ ^ self ].
	removable := aBoolean.
	self requestNewConfiguration
]
