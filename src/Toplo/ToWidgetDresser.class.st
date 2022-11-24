Class {
	#name : #ToWidgetDresser,
	#superclass : #ToCompanion,
	#instVars : [
		'theme',
		'minimalEventHandler'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - install/uninstall  hook' }
ToWidgetDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	theme := 	anElement theme.
	minimalEventHandler := ToWidgetMinimalEventHandler new.
	anElement addEventHandler: minimalEventHandler

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement removeEventHandler: minimalEventHandler.
	minimalEventHandler := nil.
	theme := 	nil

]
