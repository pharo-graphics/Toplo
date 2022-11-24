Class {
	#name : #ToTooltipModel,
	#superclass : #ToViewModel,
	#category : #'Toplo-View Models'
}

{ #category : #accessing }
ToTooltipModel >> content: aText [

	self widgetDo: [ :widget | widget content: aText ]
]

{ #category : #accessing }
ToTooltipModel >> contentString: aString [

	self content: aString asRopedText
]

{ #category : #'private - accessing - widget' }
ToTooltipModel >> privateWidgetClass [

	^ ToTooltip
]

{ #category : #enumerating }
ToTooltipModel >> whenContentChangedDo: aBlock [
	"Inform when content property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self widgetDo: [ :widget | widget whenContentChangedDo: aBlock ]
]
