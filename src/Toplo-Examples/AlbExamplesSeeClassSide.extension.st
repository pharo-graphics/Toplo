Extension { #name : #AlbExamplesSeeClassSide }

{ #category : #'*Toplo-Examples' }
AlbExamplesSeeClassSide class >> example_EditorWithSubtextElementWithBadges [

	| ed space text size start |
	ed := AlbEditorElement new.
	text := (String loremIpsum: 1000) asRopedText.
	ed text: text.
	size := 10.
	start := 10.
	10 timesRepeat: [
			| deco badge |
			deco := (AlbSubtextElement editorElement: ed)
				        interval: (start to: start + size);
				        yourself.
			deco addEventHandler: AlbSubtextElementEventHandler new.
			deco addEventHandler: (BlEventHandler
					 on: BlMouseEnterEvent
					 do: [ :event | deco border: Color black ]).
			deco addEventHandler: (BlEventHandler
					 on: BlMouseLeaveEvent
					 do: [ :event | deco border: BlBorder empty ]).
			badge := ToNumericalBadge new
				         atBottomRight;
				         count: start;
				         overflowCount: 1000;
				         yourself.
			badge attachToElement: deco.
			ed frontLayer addChild: deco.
			start := start + size + 50 ].

	space := BlSpace new.
	space root addChild: ed.
	space title: 'editor'.
	space show.
	^ ed
]
