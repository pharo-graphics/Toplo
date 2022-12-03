Class {
	#name : #ToWidgetState,
	#superclass : #Object,
	#instVars : [
		'name',
		'next',
		'beginAnimation',
		'endAnimation',
		'changeAction',
		'widgetStencil'
	],
	#category : #'Toplo-Core'
}

{ #category : #processing }
ToWidgetState >> beCurrentStateOn: aStateOwner previousState: aPreviousState [

	widgetStencil value: aStateOwner.
	self enterOn: aStateOwner previousState: aPreviousState
]

{ #category : #accessing }
ToWidgetState >> beginAnimation: anAnimation [

	beginAnimation := anAnimation
]

{ #category : #accessing }
ToWidgetState >> changeAction: aBlock [

	changeAction := aBlock
]

{ #category : #accessing }
ToWidgetState >> endAnimation: anAnimation [

	endAnimation := anAnimation
]

{ #category : #processing }
ToWidgetState >> enterOn: aStateOwner previousState: aPreviousState [

	beginAnimation ifNotNil: [ :anim | aStateOwner addAnimation: anim value ].
	changeAction ifNotNil: [ :a | a cull: self cull: aPreviousState ]
]

{ #category : #processing }
ToWidgetState >> exitOn: aStateOwner nextState: aState [

	endAnimation
		ifNil: [ aState beCurrentStateOn: aStateOwner previousState: self]
		ifNotNil: [ :animStencyl | 
			| anim |
			anim := animStencyl value.
			anim onFinishedDo: [ aState beCurrentStateOn: aStateOwner previousState: self ].
			aStateOwner addAnimation: anim ].
]

{ #category : #accessing }
ToWidgetState >> name [

	^ name
]

{ #category : #accessing }
ToWidgetState >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ToWidgetState >> next [

	^ next
]

{ #category : #accessing }
ToWidgetState >> next: aWidgetState [

	next := aWidgetState
]

{ #category : #accessing }
ToWidgetState >> widgetStencil: aBlock [

	widgetStencil := aBlock
]
