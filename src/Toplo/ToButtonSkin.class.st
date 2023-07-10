Class {
	#name : #ToButtonSkin,
	#superclass : #ToWidgetSkin,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#iconChangeHandler',
		'#labelChangeHandler',
		'#danger => ObservableSlot',
		'#dangerLook'
	],
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToButtonSkin >> danger [

	^ danger ifNil: [ danger := false ]
]

{ #category : #accessing }
ToButtonSkin >> danger: aBoolean [

	danger := aBoolean
]

{ #category : #'instance creation' }
ToButtonSkin >> dangerChanged [

	lookEventHandler ifNil: [ ^ self ].
	danger ifTrue: [
		dangerLook := ToButtonDangerLook new.
		^ self addLook: dangerLook ].
	self removeLook: dangerLook.
	dangerLook := nil
]

{ #category : #'instance creation' }
ToButtonSkin >> iconChanged: aToButtonIconChangedEvent [

	self subclassResponsibility 
]

{ #category : #initialization }
ToButtonSkin >> initialize [ 

	self class initializeSlots: self.
	super initialize.
	self whenDangerChangedDo: [ :current :previous |
		self dangerChanged ]
	
]

{ #category : #'instance creation' }
ToButtonSkin >> labelChanged: aToButtonLabelChangedEvent [

	self subclassResponsibility 
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	iconChangeHandler := BlEventHandler
		                     on: ToButtonIconChanged
		                     do: [ :evt | self iconChanged: evt ].
	labelChangeHandler := BlEventHandler
		                      on: ToButtonLabelChanged
		                      do: [ :evt | self labelChanged: evt ].
	anElement addEventHandler: iconChangeHandler.
	anElement addEventHandler: labelChangeHandler.
	self danger ifFalse: [ ^ self ].
	dangerLook := ToButtonDangerLook new.
	self addLook: dangerLook
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: iconChangeHandler.
	anElement removeEventHandler: labelChangeHandler

]

{ #category : #enumerating }
ToButtonSkin >> whenDangerChangedDo: aBlock [

	"set a block to perform after that the slot has been changed, and its action performed"

	self property: #danger whenChangedDo: aBlock
]
