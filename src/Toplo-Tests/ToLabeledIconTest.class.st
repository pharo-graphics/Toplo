"
A ToLabeledIconTest is a test class for testing the behavior of ToLabeledIcon
"
Class {
	#name : #ToLabeledIconTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
ToLabeledIconTest >> testEmpty [

	| li |
	li := ToLabeledIcon new.
	li forceLayout.
	self assert: li size equals: 0	asPoint
]

{ #category : #tests }
ToLabeledIconTest >> testEmptyAndInterspaceExact [

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

{ #category : #tests }
ToLabeledIconTest >> testEmptyAndInterspaceFlexible [

	| li container |
	container := ToElement new size: 200 asPoint.
	li := ToLabeledIcon new.
	li interspace: #flexible.
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

{ #category : #tests }
ToLabeledIconTest >> testWithIcon [

	| li |
	li := ToLabeledIcon new.
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	self assert: (li icon hasStamp: #icon).
	li forceLayout.
	self assert: li width equals: li icon width.
	self assert: li height equals: li icon height
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabel [

	| li |
	li := ToLabeledIcon new.
	li label: (ToLabel text: 'A').
	self assert: (li label hasStamp: #label).
	li forceLayout.
	self assert: li size equals: li label size
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIcon [

	| li |
	li := ToLabeledIcon new.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself)).
	li forceLayout.
	self assert: li width equals: li label width + li icon width.	
	self assert: li height equals: (li label height max: li icon height).
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconIconFirst [

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
	self assert: li icon bounds left equals: 0.
	self assert: li label bounds left equals: li icon bounds right
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconIconFirstVertical [

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
	self assert: li icon bounds top equals: 0.
	self assert: li label bounds top equals: li icon bounds bottom
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconLabelFirst [

	| li |
	li := ToLabeledIcon new.
	li labelFirst: true.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	self assert: li label bounds left equals: 0.
	self assert: li icon bounds left equals: li label bounds right
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconLabelFirstVertical [

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
	self assert: li label bounds top equals: 0.
	self assert: li icon bounds top equals: li label bounds bottom
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconVertical [

	| li |
	li := ToLabeledIcon new.
	li vertical: true.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself)).
	li forceLayout.
	self assert: li height equals: li label height + li icon height.	
	self assert: li width equals: (li label width max: li icon width).
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndInterspaceExact [

	| li |
	li := ToLabeledIcon new.
	li interspace: 10.	
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	self assert: li label bounds left equals: li icon bounds right + 10
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndInterspaceExactVertical [

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
	self assert: li label bounds top equals: li icon bounds bottom + 10
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndInterspaceFlexible [

	| li container |
	container := ToElement new size: 200 asPoint.
	li := ToLabeledIcon new.
	li matchParent.
	container addChild: li.
	li interspace: #flexible.	
	li vertical: false.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	container forceLayout.
	self assert: li label bounds right equals: container width.	
	self assert: li icon bounds left equals: 0.
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndInterspaceFlexibleVertical [

	| li container |
	container := ToElement new size: 200 asPoint.
	li := ToLabeledIcon new.
	li vertical: true.
	li matchParent.
	container addChild: li.
	li interspace: #flexible.	
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  size: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	container forceLayout.
	self assert: li label bounds bottom equals: container height.	
	self assert: li icon bounds top equals: 0.
]
