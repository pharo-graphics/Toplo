Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToOrientable + TToTripletElement + TToLabeledIcon + TToCheckable',
	#classTraits : 'TToOrientable classTrait + TToTripletElement classTrait + TToLabeledIcon classTrait + TToCheckable classTrait',
	#instVars : [
		'props',
		'optCheckableData'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #configuration }
ToButton >> beCheckable [

	self isCheckable ifTrue: [ ^ self ].
	self initializeCheckable.
	self requestNewSkin
]

{ #category : #configuration }
ToButton >> beNotCheckable [

	self isCheckable ifFalse: [ ^ self ].
	self releaseCheckable.
	optCheckableData := nil.
	self requestNewSkin
]

{ #category : #configuration }
ToButton >> checkable: aBoolean [

	aBoolean
		ifTrue: [ self beCheckable ]
		ifFalse: [ self beNotCheckable ]
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	self initializeTripletElement
]

{ #category : #'t - orientable - accessing' }
ToButton >> layoutStrategy [

	^ self layout 

	
]

{ #category : #skin }
ToButton >> newRawSkin [

	^ self isCheckable
		  ifTrue: [ ToToggleButtonSkin new ]
		  ifFalse: [ ToButtonSkin new ]
]

{ #category : #layout }
ToButton >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	self configureLayout.
	super onLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #'t - triplet element - private - accessing' }
ToButton >> props [

	^ props
]

{ #category : #'t - triplet element - private - accessing' }
ToButton >> props: aTripletElementProperties [

	props := aTripletElementProperties
]

{ #category : #'t - checkable - accessing' }
ToButton >> rawCheckableData [

	^ optCheckableData 
]

{ #category : #'t - checkable - accessing' }
ToButton >> rawCheckableData: aCheckableData [

	optCheckableData := aCheckableData
]
