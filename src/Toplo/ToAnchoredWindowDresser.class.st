Class {
	#name : #ToAnchoredWindowDresser,
	#superclass : #ToBasicWindowDresser,
	#instVars : [
		'widgetPositionInSpaceHandler'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - install/uninstall  hook' }
ToAnchoredWindowDresser >> installWidget: newWidget in: anElement [

	super installWidget: newWidget in: anElement.
	newWidget ifNil: [ ^ self ].
	widgetPositionInSpaceHandler := BlEventHandler
		                                on: BlElementPositionInSpaceChangedEvent
		                                do: [ :event | anElement position: (anElement positioningHook value: anElement value: event) ].
"	newWidget addEventHandler: widgetPositionInSpaceHandler"

	

]

{ #category : #'api - install/uninstall  hook' }
ToAnchoredWindowDresser >> uninstallWidget: oldWidget in: anElement [

	super uninstallWidget: oldWidget in: anElement.
	oldWidget ifNil: [ ^ self ].
	"oldWidget removeEventHandler: widgetPositionInSpaceHandler.
"

]
