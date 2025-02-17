Class {
	#name : #ToExTreeDataWrapper,
	#superclass : #Object,
	#instVars : [
		'holder',
		'parentWrapper',
		'dataItem',
		'childrenHook',
		'currentChildren'
	],
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #accessing }
ToExTreeDataWrapper >> childWrappersInterval [

	| firstHolder lastHolder |
	currentChildren ifNil: [ ^ 1 to: 0 ].
	firstHolder := currentChildren first holder.
	lastHolder := currentChildren last holder.
	^ firstHolder position to: lastHolder position
]

{ #category : #accessing }
ToExTreeDataWrapper >> children [

	^ (childrenHook value: dataItem) collect: [ :aChild |
		  self class new
			  parentWrapper: self;
			  wrapped: aChild;
			  childrenHook: childrenHook;
			  yourself ]
]

{ #category : #accessing }
ToExTreeDataWrapper >> childrenHook: anObject [

	childrenHook := anObject
]

{ #category : #accessing }
ToExTreeDataWrapper >> collapse [ 

	currentChildren ifNil: [ ^ self ].
	currentChildren := nil
]

{ #category : #accessing }
ToExTreeDataWrapper >> currentChildren [ 

	^ currentChildren 
]

{ #category : #accessing }
ToExTreeDataWrapper >> expand [ 

	currentChildren ifNotNil: [ ^ self ].
	currentChildren := self children
]

{ #category : #accessing }
ToExTreeDataWrapper >> hasParent: aWrapper [

	aWrapper ifNil: [ ^ false ].
	parentWrapper = aWrapper ifTrue: [ ^ true ].
	^ parentWrapper hasParent: aWrapper
]

{ #category : #accessing }
ToExTreeDataWrapper >> holder [

	^ holder
]

{ #category : #accessing }
ToExTreeDataWrapper >> holder: anObject [

	holder := anObject
]

{ #category : #initialization }
ToExTreeDataWrapper >> initialize [

	super initialize.
	childrenHook := [ :d | #(  ) ]
]

{ #category : #accessing }
ToExTreeDataWrapper >> isExpanded [ 

	^ currentChildren notNil
]

{ #category : #accessing }
ToExTreeDataWrapper >> level [

	| p lvl |
	p := parentWrapper.
	lvl := 0.
	[ p isNil ] whileFalse: [
		p := p parentWrapper.
		lvl := lvl + 1 ].
	^ lvl
]

{ #category : #accessing }
ToExTreeDataWrapper >> parentWrapper [

	^ parentWrapper
]

{ #category : #accessing }
ToExTreeDataWrapper >> parentWrapper: aWrapper [

	parentWrapper := aWrapper
]

{ #category : #accessing }
ToExTreeDataWrapper >> wrapped [

	^ dataItem
]

{ #category : #accessing }
ToExTreeDataWrapper >> wrapped: aDataItem [

	dataItem := aDataItem
]
