Class {
	#name : #ToLabelDresser,
	#superclass : #ToAbstractLabelDresser,
	#instVars : [
		'editorEventHandler',
		'textReplacedHandler'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #initialization }
ToLabelDresser >> defaultPadding [

	^ BlInsets top: 1 left: 2 bottom: 1 right: 4
]

{ #category : #'api - install/uninstall  hook' }
ToLabelDresser >> lineModeChangedIn: anElement [

	| currText default |
	currText := anElement text.
	anElement layout: anElement defaultLayout.
	default := anElement defaultTextElement.	
	anElement innerElement
		ifNil: [
			anElement innerElement: default.	
			anElement addChild: default ]
		ifNotNil: [ :inner |
			inner removeEventHandler: textReplacedHandler.
			anElement innerElement: default.
			anElement replaceChild: inner with: default ].
	textReplacedHandler := BlEventHandler
		                       on: ToTextReplacedEvent
		                       do: [ :evt | anElement text: evt text ].
	anElement innerElement addEventHandler: textReplacedHandler.
	currText ifNotNil: [anElement innerElement text: currText]
]

{ #category : #'api - install/uninstall  hook' }
ToLabelDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement padding: self defaultPadding.
	anElement whenLineModeChangedDo: [ self lineModeChangedIn: anElement ].
	anElement whenTextReplacedDo: [ anElement privateText: anElement text ].
	anElement whenEditableChangedDo: [
		anElement isEditable
			ifTrue: [ self switchEditable: anElement ]
			ifFalse: [ self switchReadOnly: anElement ] ]
]

{ #category : #'api - install/uninstall  hook' }
ToLabelDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self switchReadOnly: anElement.
	anElement innerElement ifNotNil: [
		textReplacedHandler ifNotNil: [
			anElement innerElement removeEventHandler: textReplacedHandler ] ].

]

{ #category : #'api - install/uninstall  hook' }
ToLabelDresser >> switchEditable: anElement [

	editorEventHandler ifNotNil: [ ^ self ].
	editorEventHandler := BlEventHandler
		                      on: BlMouseDownEvent
		                      do: [ :anEvent | 
			                      (anEvent modifiers isShift and: [ 
				                       anEvent modifiers isPrimaryModifier ]) 
				                      ifTrue: [ 
					                      anEvent consumed: true.
					                      anElement addEditor ] ].
	anElement addEventHandler: editorEventHandler
]

{ #category : #'api - install/uninstall  hook' }
ToLabelDresser >> switchReadOnly: anElement [

	editorEventHandler ifNil: [ ^ self ].
	anElement removeEventHandler: editorEventHandler.
	editorEventHandler := nil
]
