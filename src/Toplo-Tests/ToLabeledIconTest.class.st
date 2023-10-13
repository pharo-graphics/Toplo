"
A ToLabeledIconTest is a test class for testing the behavior of ToLabeledIcon
"
Class {
	#name : #ToLabeledIconTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core'
}

{ #category : #running }
ToLabeledIconTest >> setUp [ 

	super setUp.
	ToStyleSheetTheme cleanUp
]

{ #category : #tests }
ToLabeledIconTest >> testEmpty [

	| li |
	li := ToLabeledIcon new.
	self assert: li isIconFirst.
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
	li forceLayout.
	self assert: li width equals: li iconHolder width.
	self assert: li height equals: li iconHolder height
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabel [

	| li |
	li := ToLabeledIcon new.
	li label: (ToLabel text: 'A').
	li forceLayout.
	self assert: li size equals: li labelHolder size
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
	self assert: li width equals: li labelHolder width + li iconHolder width.	
	self assert: li height equals: (li labelHolder height max: li iconHolder height).
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconAndLabelOffset [

	| li |
	li := ToLabeledIcon new.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself)).
	li labelOffset: 80.
	li forceLayout.
	self assert: li width equals: li labelHolder width + li iconHolder width.	
	self assert: li width equals: li labelHolder width + li icon width + 20.	
	self assert: li height equals: (li labelHolder height max: li iconHolder height).
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
	self assert: li iconHolder bounds left equals: 0.
	self assert: li labelHolder bounds left equals: li iconHolder bounds right
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
	self assert: li iconHolder bounds top equals: 0.
	self assert: li labelHolder bounds top equals: li iconHolder bounds bottom
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
	self assert: li labelHolder bounds left equals: 0.
	self assert: li iconHolder bounds left equals: li label bounds right
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconLabelFirstAndLabelOffset [

	| li |
	li := ToLabeledIcon new.
	li labelFirst: true.
	self should: [ li labelOffset: 10 ] raise: Error
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconLabelFirstAndLabelOffset2 [

	| li |
	li := ToLabeledIcon new labelOffset: 10; yourself.
	self should: [ li labelFirst: true ] raise: Error
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
	self assert: li labelHolder bounds top equals: 0.
	self assert: li iconHolder bounds top equals: li labelHolder bounds bottom
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
	self assert: li height equals: li labelHolder height + li iconHolder height.	
	self assert: li width equals: (li labelHolder width max: li iconHolder width).
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
	self assert: li labelHolder bounds left equals: li iconHolder bounds right + 10
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
	self assert: li labelHolder bounds top equals: li iconHolder bounds bottom + 10
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
	self assert: li labelHolder bounds right equals: container width.	
	self assert: li iconHolder bounds left equals: 0.
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
	self assert: li labelHolder bounds bottom equals: container height.	
	self assert: li iconHolder bounds top equals: 0.
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelWithoutIconAndLabelOffset [

	| li |
	li := ToLabeledIcon new.
	li label: (ToLabel text: 'A').
	li labelOffset: 20.
	li forceLayout.
	self assert: li size equals: li label size + (20@0)
]
