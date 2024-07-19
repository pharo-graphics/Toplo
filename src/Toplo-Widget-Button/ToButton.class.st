Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToElementWithLabeledIcon + TToCheckable',
	#classTraits : 'TToElementWithLabeledIcon classTrait + TToCheckable classTrait',
	#instVars : [
		'labeledIcon',
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
ToButton >> beUncheckable [

	self isCheckable ifFalse: [ ^ self ].
	self releaseCheckable.
	optCheckableData := nil.
	self requestNewSkin
]

{ #category : #configuration }
ToButton >> checkable: aBoolean [

	aBoolean
		ifTrue: [ self beCheckable ]
		ifFalse: [ self beUncheckable ]
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	labeledIcon := ToLabeledIcon new.
	self addChild: labeledIcon.
	labeledIcon constraintsDo: [ :c |
		c linear vertical alignCenter.
		c linear horizontal alignCenter.
		c frame vertical alignCenter.
		c frame horizontal alignCenter ].
	self fitContent
]

{ #category : #'t - element with labeled icon - accessing' }
ToButton >> labeledIcon [ 

	^ labeledIcon
]

{ #category : #skin }
ToButton >> newRawSkin [

	^ self isCheckable
		  ifTrue: [ ToToggleButtonSkin new ]
		  ifFalse: [ ToButtonSkin new ]
]

{ #category : #'t - checkable - accessing' }
ToButton >> rawCheckableData [

	^ optCheckableData 
]

{ #category : #'t - checkable - accessing' }
ToButton >> rawCheckableData: aCheckableData [

	optCheckableData := aCheckableData
]
