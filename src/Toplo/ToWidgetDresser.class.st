Class {
	#name : #ToWidgetDresser,
	#superclass : #ToCompanion,
	#instVars : [
		'theme',
		'unabled'
	],
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToWidgetDresser >> initialize [ 

	super initialize.
	unabled := true.

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	theme := 	anElement theme

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	theme := 	nil

]
