Class {
	#name : 'TToElementWithLabeledIconTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core',
	#package : 'Toplo-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
TToElementWithLabeledIconTest >> setUp [ 

	super setUp.
	ToTheme cleanUp
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testBeHorizontal [

	| li |
	li := self testInitialize.
	li beVertical.
	self assert: li isVertical.
	li beHorizontal.
	self assert: li isHorizontal
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testBeIconFirst [

	| li |
	li := self testInitialize.
	li iconImage: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself).
	li beIconFirst.
	self assert: li isIconFirst
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testBeLabelFirst [

	| li |
	li := self testInitialize.
	li iconImage: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself).
	li beLabelFirst.
	self assert: li isLabelFirst
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testBeVertical [

	| li |
	li := self testInitialize.
	li beVertical.
	self assert: li isVertical
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testFiller [

	| li |
	li := self testInitialize.
	self assert: li filler notNil.
	self assert: li filler size equals: 0 asPoint
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testFlexible [

	| li |
	li := self testInitialize.
	self assert: li filler notNil.
	self assert: li filler size equals: 0 asPoint.
	li flexible: true.
	li forceLayout.
	self assert: li isFlexible
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testFlexibleInEmpty [

	| li container |
	container := ToElement new size: 200 asPoint.
	li := ToLabeledIcon new.
	li flexible: true.
	self assert: li isFlexible.
	li matchParent.
	container addChild: li.
	li forceLayout.
	self assert: li size equals: 200 asPoint.
	li vFitContent.
	li forceLayout.
	self assert: li width equals: 200.
	self assert: li height equals: 0.
	li label: (ToLabel text: 'X').
	li forceLayout.
	self assert: li height equals: li label height.
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testFlexibleWithLabel [

	| li container |
	container := ToElement new size: 200 asPoint.
	li := ToLabeledIcon new.
	li matchParent.
	container addChild: li.
	li flexible: true.	
	li vertical: false.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	container forceLayout.
	self assert: li labelHolder bounds right equals: container width.	
	self assert: li iconHolder bounds left equals: 0.
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testFlexibleWithLabelAndVertical [

	| li container |
	container := ToElement new size: 200 asPoint.
	li := ToLabeledIcon new.
	li vertical: true.
	li matchParent.
	container addChild: li.
	li flexible: true.	
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	container forceLayout.
	self assert: li labelHolder bounds bottom equals: container height.	
	self assert: li iconHolder bounds top equals: 0.
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testHasIcon [

	| li |
	li := self testInitialize.
	self deny: li hasIcon.
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	self assert: li hasIcon
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testHasLabel [

	| li |
	li := self testInitialize.
	self deny: li hasLabel.
	li label: (ToLabel text: 'A').
	self assert: li hasLabel.

]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIcon [

	| li |
	li := self testInitialize.
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	self assert: li width equals: li iconHolder width.
	self assert: li height equals: li iconHolder height.
	^ li
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIconDo [

	| li wasThere |
	li := self testInitialize.
	wasThere := false.
	li iconDo: [ :ic | wasThere := true ].
	self deny: wasThere.

	li icon: ToImage new.
	li iconDo: [ :ic | wasThere := true ].
	self assert: wasThere
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIconFirst [

	| li |
	li := self testInitialize.
	li iconImage: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself).
	li labelText: 'X'.
	li iconFirst: true.
	li forceLayout.
	self assert: (li icon bounds inParent: li) right equals: (li label bounds inParent: li) left.
	^ li
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIconHolder [

	| li |
	li := self testInitialize.
	self assert: li iconHolder hasChildren not.
	self assert: li iconHolder size equals: 0 asPoint.
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	self assert: li width equals: li iconHolder width.
	self assert: li height equals: li iconHolder height.
	^ li
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIconHolderHeight [

	| li |
	li := self testWithLabelAndIcon.
	li iconHolderHeight: 40.
	li forceLayout.
	self assert: li height equals: (li labelHolder height max: li iconHolder height).	
	self assert: li height equals: (li labelHolder height max: li iconHolderHeight)
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIconHolderHeightVertical [

	| li |
	li := self testWithLabelAndIcon.
	li beVertical.
	li iconHolderHeight: 40.
	li forceLayout.
	self assert: li height equals: (li labelHolder height + li iconHolder height).	
	self assert: li height equals: (li labelHolder height + li iconHolderHeight).
	self assert: li width equals: (li labelHolder width max: li iconHolder width).
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIconHolderWidth [

	| li |
	li := self testWithLabelAndIcon.
	li iconHolderWidth: 40.
	li forceLayout.
	self assert: li width equals: li labelHolder width + li iconHolder width.	
	self assert: li width equals: li labelHolder width + li iconHolderWidth.	
	self assert: li height equals: (li labelHolder height max: li iconHolder height).
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIconHolderWidthVertical [

	| li |
	li := self testWithLabelAndIcon.
	li beVertical.
	li iconHolderWidth: 40.
	li forceLayout.
	self assert: li width equals: (li labelHolder width max: li iconHolder width).	
	self assert: li width equals: (li labelHolder width max: li iconHolderWidth).	
	self assert: li height equals: (li labelHolder height + li iconHolder height).
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIconImage [

	| li |
	li := self testInitialize.
	li iconImage: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself).
	li forceLayout.
	self assert: li width equals: li iconHolder width.
	self assert: li height equals: li iconHolder height.
	^ li
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testInitialize [

	| li |
	li := ToElementWithLabeledIconForTest new.
	self assert: li isIconFirst.
	self assert: li isHorizontal.
	li forceLayout.
	self assert: li size equals: 0	asPoint.
	^ li
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testInterspace [

	| li |
	li := ToLabeledIcon new.
	li interspace: 10.
	li forceLayout.
	self assert: li size equals: 10 asPoint.
	li vFitContent.
	li forceLayout.
	self assert: li width equals: 10.
	self assert: li height equals: 10.
	li label: (ToLabel text: 'X').
	li forceLayout.
	self assert: li height equals: li label height.	
	self assert: li width equals: li label width + 10.
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testInterspaceWithLabel [

	| li |
	li := ToLabeledIcon new.
	li interspace: 10.	
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	self assert: li labelHolder bounds left equals: li iconHolder bounds right + 10
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testInterspaceWithLabelAndVertical [

	| li |
	li := ToLabeledIcon new.
	li interspace: 10.	
	li vertical: true.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	self assert: li labelHolder bounds top equals: li iconHolder bounds bottom + 10
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIsExact [

	| li |
	li := self testInitialize.
	self assert: li isExact equals: li labeledIcon isExact

]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIsFlexible [

	| li |
	li := self testInitialize.
	self deny: li isFlexible.
	li flexible: true.
	self assert: li isFlexible
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIsIconFirst [

	| li |
	li := self testInitialize.
	li beIconFirst.
	self assert: li isIconFirst.
	self deny: li isLabelFirst.

]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testIsLabelFirst [

	| li |
	li := self testInitialize.
	li beLabelFirst.
	self assert: li isLabelFirst.
	self deny: li isIconFirst.


]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testLabel [

	| li |
	li := self testInitialize.
	li label: (ToLabel text: 'A').
	li forceLayout.
	self assert: li size equals: li labelHolder size.
	^ li
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testLabelFirst [

	| li |
	li := self testInitialize.
	li iconImage: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself).
	li labelText: 'X'.
	li labelFirst: true.
	li forceLayout.
	self assert: (li label bounds inParent: li) right equals: (li icon bounds inParent: li) left.
	^ li
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testLabelHolder [

	| li |
	li := self testInitialize.
	self assert: li labelHolder hasChildren not.
	self assert: li labelHolder size equals: 0 asPoint.
	li label: (ToLabel text: 'A').
	li forceLayout.
	self assert: li size equals: li labelHolder size.
	^ li
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testLabelText [

	| li |
	li := self testInitialize.
	li labelText: 'A' asRopedText.
	li forceLayout.
	self assert: li label text asString equals: 'A'.
	self assert: li size equals: li labelHolder size.
	li labelText: 'X'.
	li forceLayout.
	self assert: li label text asString equals: 'X'.
	self assert: li size equals: li labelHolder size.
	^ li
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testWithLabelAndIcon [

	| li |
	li := self testLabel.
	li icon: (ToImage inner: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself)).
	li forceLayout.
	self assert: li width equals: li labelHolder width + li iconHolder width.	
	self assert: li height equals: (li labelHolder height max: li iconHolder height).
	^ li
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testWithLabelAndIconIconFirst [

	| li |
	li := ToLabeledIcon new.
	li labelFirst: true.
	li labelFirst: false.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	self assert: li iconHolder bounds left equals: 0.
	self assert: li labelHolder bounds left equals: li iconHolder bounds right
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testWithLabelAndIconIconFirstVertical [

	| li |
	li := ToLabeledIcon new.
	li labelFirst: true.
	li labelFirst: false.
	li vertical: true.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	self assert: li iconHolder bounds top equals: 0.
	self assert: li labelHolder bounds top equals: li iconHolder bounds bottom
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testWithLabelAndIconLabelFirst [

	| li |
	li := ToLabeledIcon new.
	li labelFirst: true.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	self assert: li labelHolder bounds left equals: 0.
	self assert: li iconHolder bounds left equals: li label bounds right
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testWithLabelAndIconLabelFirstVertical [

	| li |
	li := ToLabeledIcon new.
	li labelFirst: true.
	li vertical: true.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	self assert: li labelHolder bounds top equals: 0.
	self assert: li iconHolder bounds top equals: li labelHolder bounds bottom
]

{ #category : 'tests' }
TToElementWithLabeledIconTest >> testWithLabelAndIconVertical [

	| li |
	li := ToLabeledIcon new.
	li vertical: true.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself)).
	li forceLayout.
	self assert: li height equals: li labelHolder height + li iconHolder height.	
	self assert: li width equals: (li labelHolder width max: li iconHolder width).
]
