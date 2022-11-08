Class {
	#name : #ToWidgetHelpEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'helpOpenTask',
		'helpElement'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - accessing' }
ToWidgetHelpEventHandler >> eventsToHandle [

	^ { 
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  BlMouseDownEvent }
]

{ #category : #'api - accessing' }
ToWidgetHelpEventHandler >> hideHelpFor: aWidget [

	helpOpenTask ifNotNil: [ 
		aWidget dequeueTask: helpOpenTask.
		helpOpenTask := nil ].
	helpElement ifNotNil: [ 
		helpElement removeFromParent.
		helpElement := nil ]
]

{ #category : #'api - accessing' }
ToWidgetHelpEventHandler >> mouseDownEvent: anEvent [

	self hideHelpFor: anEvent currentTarget

]

{ #category : #'api - accessing' }
ToWidgetHelpEventHandler >> mouseEnterEvent: anEvent [

	helpOpenTask ifNotNil: [ anEvent currentTarget dequeueTask: helpOpenTask ].
	helpElement ifNotNil: [ helpElement := nil ].
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	helpOpenTask := BlDelayedTaskAction new
		                delay: 1000 milliSeconds;
		                action: [ 
			                self popupHelpFor: anEvent currentTarget.
			                helpOpenTask := nil ].
	anEvent currentTarget enqueueTask: helpOpenTask
]

{ #category : #'api - accessing' }
ToWidgetHelpEventHandler >> mouseLeaveEvent: anEvent [

	self hideHelpFor: anEvent currentTarget

]

{ #category : #'private - help' }
ToWidgetHelpEventHandler >> popupHelpFor: aWidget [

	aWidget viewModelDo: [ :vm | 
		(vm help isNil or: [ helpElement notNil ]) ifTrue: [ ^ self ].
		self flag: 'TODO'.
		helpElement := ToLabel new
			               beMultiLine;
			               text: vm help;
			               preventMouseEvents;
			               yourself.
		helpElement background: (Color yellow alpha: 0.4).
		helpElement relocate: aWidget bounds bottomRight.
		aWidget topMostParent addChild: helpElement ]
]
