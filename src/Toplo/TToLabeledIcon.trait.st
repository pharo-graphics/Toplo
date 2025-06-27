Trait {
	#name : #TToLabeledIcon,
	#category : #'Toplo-Core'
}

{ #category : #'t - labeled icon' }
TToLabeledIcon >> endIcon [

	^ self endElement
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> endIcon: anElement [

	self endElement: anElement
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> hasEndIcon [

	^ self endIcon notNil
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> hasIcon [

	^ self icon notNil
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> hasLabel [

	^ self label notNil
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> hideEndIcon [

	^ self hideEnd
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> hideEndIcon: aBoolean [

	self hideEnd: aBoolean
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> hideIcon [

	^ self hideStart
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> hideIcon: aBoolean [

	self hideStart: aBoolean
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> hideLabel [

	^ self hideMiddle
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> hideLabel: aBoolean [

	self hideMiddle: aBoolean
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> icon [

	^ self startElement
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> icon: anElement [

	self startElement: anElement
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> iconContainer [

	^ self startContainer
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> iconDo: aBlock [

	self icon ifNotNil: [ :ic | aBlock value: ic ]
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> iconImage [

	^ self icon ifNotNil: [:ic | ic innerImage ]
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> iconImage: anElement [

	self icon: (ToImage inner: anElement)
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> label [

	^ self middleElement
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> label: anElement [

	self middleElement: anElement
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> labelContainer [

	^ self middleContainer
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> labelDo: aBlock [

	self label ifNotNil: [ :la | aBlock value: la ]
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> labelText [

	self hasLabel ifFalse: [ ^ nil ].
	^ self label text asString
]

{ #category : #'t - labeled icon' }
TToLabeledIcon >> labelText: aText [

	self label: (ToLabel text: aText asRopedText).
]
