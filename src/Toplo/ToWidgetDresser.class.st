Class {
	#name : #ToWidgetDresser,
	#superclass : #ToElementCompanion,
	#instVars : [
		'theme'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - hooks' }
ToWidgetDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	theme := 	anElement theme

]

{ #category : #'api - hooks' }
ToWidgetDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
]
