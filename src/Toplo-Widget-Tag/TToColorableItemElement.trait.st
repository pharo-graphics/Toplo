Trait {
	#name : #TToColorableItemElement,
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'t - colorable item element' }
TToColorableItemElement >> backgroundColor: aColorOrNil [

	aColorOrNil
		ifNil: [ self removeStamp: #backgroundColor ]
		ifNotNil: [ self addStamp: #backgroundColor withValue: aColorOrNil ]
]

{ #category : #'t - colorable item element' }
TToColorableItemElement >> borderless: aBoolean [

	aBoolean
		ifTrue: [ self addStamp: #borderless ]
		ifFalse: [ self removeStamp: #borderless ]
]

{ #category : #'t - colorable item element' }
TToColorableItemElement >> foregroundColor: aColorOrNil [

	aColorOrNil
		ifNil: [ self removeStamp: #foregroundColor ]
		ifNotNil: [ self addStamp: #foregroundColor withValue: aColorOrNil ]
]
