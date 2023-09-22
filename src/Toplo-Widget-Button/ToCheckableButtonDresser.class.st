Class {
	#name : #ToCheckableButtonDresser,
	#superclass : #ToWidgetDresser,
	#instVars : [
		'checkableHandler'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonDresser >> checkEvent: anEvent in: anElement [
	"checkEvent:in: can be send either because of a click or because the checkable as been checked programmatically"

	| tag th newState |
	newState := anEvent current
		       ifNil: [ ToIndeterminateState new]
		       ifNotNil: [ :v |
			       v
				       ifTrue: [ ToCheckedState new ]
				       ifFalse: [ ToUncheckedState new ] ].
	anElement switchToSkinState: newState.
	" remove previous tag "
	th := anElement toTheme.
	{
		th checkboxIndeterminateTag.
		th checkboxCheckedTag.
		th checkboxUncheckedTag } do: [ :t |
		anElement icon innerImage removeStyleTag: t ].
	" compute an set the new tag "
	tag := anEvent current
		       ifNil: [ th checkboxIndeterminateTag ]
		       ifNotNil: [ :v |
			       v
				       ifTrue: [ th checkboxCheckedTag ]
				       ifFalse: [ th checkboxUncheckedTag ] ].
	anElement icon innerImage addStyleTag: tag.
	" update the skin to take the new tag into account "
	anElement icon innerImage updateSkin.
	anElement dispatchLookEvent: ToClickedLookEvent new
]

{ #category : #'events handling' }
ToCheckableButtonDresser >> clicked: anElement [

	anElement switchToNextState.
	super clicked: anElement.

	

]

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	checkableHandler := BlEventHandler
		                    on: ToCheckableCheckEvent
		                    do: [ :event | self checkEvent: event in: anElement ].
	anElement addEventHandler: checkableHandler.
	"anElement innerElement preventChildrenMouseEvents"
]

{ #category : #'api - install/uninstall  hook' }
ToCheckableButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: checkableHandler
]
