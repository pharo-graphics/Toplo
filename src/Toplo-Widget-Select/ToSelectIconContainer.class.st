Class {
	#name : #ToSelectIconContainer,
	#superclass : #ToElement,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectIconContainer >> initialize [

	super initialize.
	self
		fitContent;
		id: #iconContainer;
		layout: BlFrameLayout new;
		constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : #'api - hooks' }
ToSelectIconContainer >> onInstalledIn: aSelect [

	select := aSelect
]

{ #category : #'api - hooks' }
ToSelectIconContainer >> onUninstalledIn: aSelect [

	select := nil
]
