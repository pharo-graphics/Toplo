Class {
	#name : #ToButtonSkin,
	#superclass : #ToWidgetSkin,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'iconChangeHandler',
		'labelChangeHandler',
		'danger'
	],
	#category : #'Toplo-Widget-Button-Skin'
}

{ #category : #accessing }
ToButtonSkin >> danger [

	^ danger ifNil: [ danger := false ]
]

{ #category : #accessing }
ToButtonSkin >> danger: aBoolean [

	danger := aBoolean
]

{ #category : #testing }
ToButtonSkin >> hasBackground [ 

	^ false
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	iconChangeHandler := BlEventHandler
		                     on: ToButtonIconChanged
		                     do: [ :evt | self onInstalledIconIn: anElement. ].
	labelChangeHandler := BlEventHandler
		                      on: ToButtonLabelChanged
		                      do: [ :evt | self onInstalledLabelIn: anElement ].
	anElement addEventHandler: iconChangeHandler.
	anElement addEventHandler: labelChangeHandler.


]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> mainLookIn: anElement [

	^ ToButtonDefaultLook new
]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onInstalledIconIn: anElement [


]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> onInstalledLabelIn: anElement [


]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: iconChangeHandler.
	anElement removeEventHandler: labelChangeHandler.
	super uninstallEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToButtonSkin >> whenAddedToSpace: anEvent in: anElement [

	super whenAddedToSpace: anEvent in: anElement.
	self onInstalledLabelIn: anElement.
	self onInstalledIconIn: anElement.
	self danger ifFalse: [ ^ self ].
	self addLook: (ToButtonDangerLook new background: self hasBackground; yourself)
]
