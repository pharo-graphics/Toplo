Class {
	#name : #ToSelectListEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'api - accessing' }
ToSelectListEventHandler >> eventsToHandle [

	^ {
		  ToListDeselectIndexEvent.
		  ToListSelectIndexEvent }
]

{ #category : #'element handlers' }
ToSelectListEventHandler >> listDeselectIndexEvent: anEvent [

	select
		deselectIndex: anEvent index;
		refreshNodes
]

{ #category : #'element handlers' }
ToSelectListEventHandler >> listSelectIndexEvent: anEvent [

	select
		selectIndex: anEvent index;
		refreshNodes
]

{ #category : #accessing }
ToSelectListEventHandler >> select: aSelect [

	select := aSelect
]
