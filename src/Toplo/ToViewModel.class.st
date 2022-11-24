Class {
	#name : #ToViewModel,
	#superclass : #ToCompanion,
	#category : #'Toplo-Core'
}

{ #category : #'api - enablement' }
ToViewModel >> disable [
	"Disable the view"
	
	self widgetDo: [ :widget | widget disable ]
]

{ #category : #'api - enablement' }
ToViewModel >> disabled: aBoolean [

	aBoolean value
		ifTrue: [ self disable ]
		ifFalse: [ self enable ]
]

{ #category : #'api - enablement' }
ToViewModel >> enable [
	"Enable the view"
	
	self widgetDo: [ :widget | widget enable ]
]

{ #category : #'api - enablement' }
ToViewModel >> enabled: aBoolean [

	aBoolean value
		ifTrue: [ self enable ]
		ifFalse: [ self disable ]
]

{ #category : #'change reporting' }
ToViewModel >> invalidate [

	" invalidate was sent to the widget. Subclasses may have action to run model side before invalidation"
]

{ #category : #'accessing - widget' }
ToViewModel >> onWidget [

	^ self privateNewWidget
]

{ #category : #'private - accessing - widget' }
ToViewModel >> privateNewWidget [

	^ self privateWidgetClass new
		  viewModel: self;
		  yourself
]

{ #category : #'private - accessing - widget' }
ToViewModel >> privateWidgetClass [

	^ self subclassResponsibility 
]

{ #category : #'api - tooltip' }
ToViewModel >> tooltipContent: aText [
	"Set a tooltip text to display to the user if he let the mouse over the widget."

	self widgetDo: [ :widget | widget tooltipContent: aText ]
]

{ #category : #'api - tooltip' }
ToViewModel >> tooltipString: aString [
	"Set a tooltip string to display to the user if he let the mouse over the widget."

	self tooltipContent: aString asRopedText
]

{ #category : #'api - properties change hook' }
ToViewModel >> whenTooltipChangedDo: aBlock [
	"Inform when tooltip has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self widgetDo: [ :widget | widget whenTooltipChangedDo: aBlock ]
]
