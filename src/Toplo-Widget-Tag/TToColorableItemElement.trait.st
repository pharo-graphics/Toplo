Trait {
	#name : #TToColorableItemElement,
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'t - colorable item element' }
TToColorableItemElement >> backgroundColor: aColorOrNil [

	aColorOrNil
		ifNil: [ self removeStamp: #'background-color' ]
		ifNotNil: [ self addStamp: #'background-color' withValue: aColorOrNil ]
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
		ifNil: [ self removeStamp: #'foreground-color' ]
		ifNotNil: [ self addStamp: #'foreground-color' withValue: aColorOrNil ]
]
