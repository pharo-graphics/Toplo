Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToOrientable + TToTripletElement + TToLabeledIcon + TToCheckable',
	#classTraits : 'TToOrientable classTrait + TToTripletElement classTrait + TToLabeledIcon classTrait + TToCheckable classTrait',
	#instVars : [
		'optCheckableData',
		'tripletProperties'
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

{ #category : #'t - checkable - accessing' }
ToButton >> checkableData [

	^ optCheckableData 
]

{ #category : #'t - checkable - accessing' }
ToButton >> checkableData: aCheckableData [

	optCheckableData := aCheckableData
]

{ #category : #'t - labeled icon' }
ToButton >> icon: anElement [

	self icon = anElement ifTrue: [ ^ self ].
	self iconDo: [ :ic | ic removeStamp: #'parent-button' ].
	self startElement: anElement.
	self iconDo: [ :ic | ic addStamp: #'parent-button' withValue: self ]
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	self initializeTripletElement
]

{ #category : #'t - toElement' }
ToButton >> knownMinWidth [

	| w |
	w := super knownMinWidth.
	self childrenDo: [ :child | w := w + child measuredWidth ].
	^ w 
]

{ #category : #'t - labeled icon' }
ToButton >> label: anElement [

	self label = anElement ifTrue: [ ^ self ].
	self labelDo: [ :lab | lab removeStamp: #'parent-button' ].
	self middleElement: anElement.
	self labelDo: [ :lab | lab addStamp: #'parent-button' withValue: self ].

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
ToButton >> properties [

	^ tripletProperties
]

{ #category : #'t - triplet element - private - accessing' }
ToButton >> properties: aTripletElementProperties [

	tripletProperties := aTripletElementProperties
]
