Class {
	#name : #ToEnableableDresser,
	#superclass : #ToDresser,
	#instVars : [
		'enabledHandler',
		'disabledHandler'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - install/uninstall  hook' }
ToEnableableDresser >> disabledEvent: anEvent on: anElement [
]

{ #category : #'api - install/uninstall  hook' }
ToEnableableDresser >> enabledEvent: anEvent on: anElement [
]

{ #category : #'api - install/uninstall  hook' }
ToEnableableDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	enabledHandler := BlEventHandler on: ToWidgetEnabledEvent do: [ :event | self enabledEvent: event on: anElement ].
	disabledHandler := BlEventHandler on: ToWidgetDisabledEvent do: [ :event | self disabledEvent: event on: anElement ].
	
	anElement addEventHandler: enabledHandler.
	anElement addEventHandler: disabledHandler
]

{ #category : #'api - install/uninstall  hook' }
ToEnableableDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: enabledHandler.
	anElement removeEventHandler: disabledHandler
]
