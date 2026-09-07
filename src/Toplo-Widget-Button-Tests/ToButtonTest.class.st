Class {
	#name : #ToButtonTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-Button-Tests-Core'
}

{ #category : #tests }
ToButtonTest >> testButton [
	"Test default values of a new button"

	| button |
	button := ToButton new.

	self assert: button isHorizontal.

	self assert: button isStartToEnd.
	self deny: button isEndToStart.

	self assert: button icon isNil.
	self assert: button label isNil
]

{ #category : #'click handler' }
ToButtonTest >> testCheckable [

	| but handler |
	but := ToButton new.
	self deny: but isCheckable.
	self assert: but checkableState isNil.
	handler := but checkableEventHandler.
	self assert: handler isNil.
	but checkable: true.
	self assert: but checkableState notNil.
	handler := but checkableEventHandler.
	self assert: handler notNil.
	self assert: (but eventDispatcher handlers includes: handler).
	but checkable: false.
	self assert: but checkableState isNil.
	self deny: (but eventDispatcher handlers includes: handler).
	self assert: but checkableEventHandler isNil
]

{ #category : #'click handler' }
ToButtonTest >> testClickAborted [

	| button count |
	count := 0.
	button := ToButton new.
	button labelText: 'XXXXX'.
	button icon: (ToImage inner: (BlElement new
				  extent: 30 @ 30;
				  background: Color blue;
				  yourself)).
	button matchParent.
	button clickAction: [ count := count + 1 ].
	space deferAndSettle: [ space root addChild: button ].

	button eventSimulator mouseDown.
	button icon eventSimulator mouseUp.
	self assert: count equals: 1.

	button icon eventSimulator mouseDown.
	button eventSimulator mouseUp.
	self assert: count equals: 2.

	button label eventSimulator mouseDown.
	button eventSimulator mouseUp.
	self assert: count equals: 3.

	button eventSimulator mouseDown.
	button label eventSimulator mouseUp.
	self assert: count equals: 4
]

{ #category : #'click handler' }
ToButtonTest >> testClickAborted2 [

	| button count |
	count := 0.
	button := ToButton new.
	button labelText: 'XXXXX'.
	button icon: (ToImage inner: (BlElement new
				  extent: 30 @ 30;
				  background: Color blue;
				  yourself)).
	button matchParent.
	button clickAction: [ count := count + 1 ].
	space deferAndSettle: [ space root addChild: button ].

	button label eventSimulator mouseDown.
	button icon eventSimulator mouseUp.
	self assert: count equals: 1
]

{ #category : #'click handler' }
ToButtonTest >> testClickWhenDisabled [

	| but done |
	but := ToButton new.
	space deferAndSettle: [ but disable ].
	done := 0.
	but clickAction: [ done := done +1 ].
	self assert: done equals: 0
]

{ #category : #'click handler' }
ToButtonTest >> testClickWith1Action [

	| but done |
	but := ToButton new.
	space deferAndSettle: [ space root addChild: but ].
	done := 0.
	but clickAction: [ done := done + 1 ].
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self assert: done equals: 1
]

{ #category : #'click handler' }
ToButtonTest >> testClickWith2Actions [

	| but done link1 link2 |
	but := ToButton new.
	space deferAndSettle: [ space root addChild: but ].
	done := 0.
	link1 := but newClickAction: [ done := done + 1 ].
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self assert: done equals: 1.

	link2 := but newClickAction: [ done := done + 10 ].
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self assert: done equals: 12.

	link2 unlink.
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self assert: done equals: 13.

	link1 unlink.
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self assert: done equals: 13
]

{ #category : #'click handler' }
ToButtonTest >> testClickWithoutAction [

	| but |
	but := ToButton new.
	but dispatchEvent: BlMouseUpEvent primary asClickEvent
]

{ #category : #'click handler' }
ToButtonTest >> testLinkClickAction [

	| but count |
	count := 0.
	but := ToButton new.
	but matchParent.
	but clickAction: [ count := count + 1 ].
	space deferAndSettle: [ space root addChild: but ].
	but eventSimulator mouseDown.
	but eventSimulator mouseUp.
	self assert: count equals: 1
]

{ #category : #'click handler' }
ToButtonTest >> testRemoveClickAction [

	| but done link |
	but := ToButton new.
	space deferAndSettle: [ space root addChild: but ].
	done := 0.
	link := but newClickAction: [ done := done + 1 ].
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self assert: done equals: 1.

	link unlink.
	but dispatchEvent: BlMouseUpEvent primary asClickEvent.
	self assert: done equals: 1
]
