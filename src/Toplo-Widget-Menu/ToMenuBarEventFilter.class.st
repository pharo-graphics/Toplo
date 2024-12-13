Class {
	#name : #ToMenuBarEventFilter,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target'
	],
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #'api - accessing' }
ToMenuBarEventFilter >> eventsToHandle [

	^ {  BlMouseUpEvent}
]

{ #category : #'mouse handlers' }
ToMenuBarEventFilter >> mouseUpEvent: anEvent [
	"switch auto open filter "

	" do nothing in case of a sub-menuBar "
	target parentItemListHolderDo: [ :mb | ^ self ].
	
	" mouse up outside the menubar cancels autoOpen "
	(target itemContaining: anEvent target) ifNotNil: [ :found |
		found isMenu ifTrue: [ ^ self ] ].
	target cancelAutoOpen 
]

{ #category : #accessing }
ToMenuBarEventFilter >> target [

	^ target
]

{ #category : #accessing }
ToMenuBarEventFilter >> target: anObject [

	target := anObject
]
