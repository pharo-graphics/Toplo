Class {
	#name : #ToElementWithPlaceholderEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'prevMinHeight',
		'prevMinWidth'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - accessing' }
ToElementWithPlaceholderEventHandler >> eventsToHandle [

	^ { ToPlaceholderShownEvent. ToPlaceholderHiddenEvent }
]

{ #category : #'element handlers' }
ToElementWithPlaceholderEventHandler >> placeHolderHiddenEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	prevMinHeight ifNotNil: [ 
		target minHeight: prevMinHeight.
		prevMinHeight := nil ].
	prevMinWidth ifNotNil: [ 
		target minWidth: prevMinWidth.
		prevMinWidth := nil ].

]

{ #category : #'element handlers' }
ToElementWithPlaceholderEventHandler >> placeHolderShownEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target hasPlaceholderMinHeight ifTrue: [
		prevMinHeight := target minHeight.
		target minHeight: target placeholderMinHeight ].
	target hasPlaceholderMinWidth ifFalse: [ ^ self ].
	prevMinWidth := target minWidth.
	target minWidth: target placeholderMinWidth
]
