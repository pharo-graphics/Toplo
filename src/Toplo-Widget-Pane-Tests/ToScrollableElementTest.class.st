"
I check that the mouse wheel scrolls a `ToScrollableElement` that has a scrollbar attached to it.
"
Class {
	#name : #ToScrollableElementTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Widget-Pane-Tests'
}

{ #category : #tests }
ToScrollableElementTest >> testMouseWheelScrollsElementWithScrollbar [

	| scrollable |
	scrollable := ToScrollableElement instanceTallPane.
	space root addChild: (ToScrollableElement demoWithScrollbar: scrollable).
	5 timesRepeat: [ space settle ].
	scrollable dispatchEvent: (BlMouseWheelEvent new
		 position: 20 @ 50;
		 vector: 0 @ -3;
		 modifiers: BlKeyModifiers new;
		 yourself).
	5 timesRepeat: [ space settle ].
	self assert: scrollable scrollPosition y < 0
]
