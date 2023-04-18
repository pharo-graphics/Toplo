Class {
	#name : #ToListDefaultPrimarySelectionDresser,
	#superclass : #ToListPrimarySelectionDresser,
	#instVars : [
		'backgroundElement',
		'labelAdaptionHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListDefaultPrimarySelectionDresser >> actualBackgroundColor [

	^ self listElement infinite isFocused
		  ifTrue: [ self theme item selectedColor ]
		  ifFalse: [ self theme item selectedBlurredColor ]
]

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> adaptLabel: aLabel in: anElement [

	aLabel foreground: backgroundElement background contrastingBlackAndWhiteColor
]

{ #category : #dressing }
ToListDefaultPrimarySelectionDresser >> backgroundChangedIn: anElement [

	listElement ifNil: [ ^ self ].
	anElement nodesDo: [ :node | node dispatchEvent: (ToListSelectionDecorationChangedEvent new decoration: anElement; yourself) ]
]

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> blurEvent: anEvent in: anElement [

	super blurEvent: anEvent in: anElement.
	backgroundElement background: self actualBackgroundColor.
	self backgroundChangedIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> focusEvent: anEvent in: anElement [

	super focusEvent: anEvent in: anElement.
	backgroundElement background: self actualBackgroundColor.
	self backgroundChangedIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> secondarySelectionAddedIn: anElement [

	super secondarySelectionAddedIn: anElement.
	anElement padding: (BlInsets all: 3)
]

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> secondarySelectionRemovedIn: anElement [

	super secondarySelectionRemovedIn: anElement.
	anElement padding: (BlInsets all: 0)
]

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> whenAddedToParent: anElement [

	super whenAddedToParent: anElement.

	backgroundElement := ToElement new matchParent.

	labelAdaptionHandler := BlEventHandler
		                        on: ToListSelectionLabelInDecorationAdaptionEvent
		                        do: [ :event | self adaptLabel: event label in: anElement ].
	anElement addEventHandler: labelAdaptionHandler.

	anElement background: Color white.
	backgroundElement background: self actualBackgroundColor.

	anElement nodesDo: [ :node |
		node dispatchEvent: (ToListSelectionDecorationChangedEvent new
				 decoration: anElement;
				 yourself) ].

	anElement addChild: backgroundElement
]

{ #category : #'api - install/uninstall  hook' }
ToListDefaultPrimarySelectionDresser >> whenRemovedFromParent: anElement [

	anElement removeEventHandler: labelAdaptionHandler.
	
	anElement removeChild: backgroundElement.

	labelAdaptionHandler := nil.
	backgroundElement := nil.

	super whenRemovedFromParent: anElement
]
