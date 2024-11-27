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

	^ { BlMouseDownEvent.  }
]

{ #category : #'mouse handlers' }
ToMenuBarEventFilter >> mouseDownEvent: anEvent [
	"switch auto=open filter "

	" mouse down on the menubar, outside menu items or, ouside the menubar is a pick outside "

	(anEvent target = target or: [
		 target items noneSatisfy: [ :m |
			 anEvent target hasInParentChain: m ] ]) ifTrue: [
		target dispatchEvent: ToPickOutsideEvent new.
		^ self ].

	target dispatchEvent: ToPickInsideEvent new
]

{ #category : #accessing }
ToMenuBarEventFilter >> target [

	^ target
]

{ #category : #accessing }
ToMenuBarEventFilter >> target: anObject [

	target := anObject
]
