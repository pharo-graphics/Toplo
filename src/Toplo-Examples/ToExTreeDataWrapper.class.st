Class {
	#name : #ToExTreeDataWrapper,
	#superclass : #Object,
	#instVars : [
		'dataAccessor',
		'parentWrapper',
		'dataItem',
		'childrenHook',
		'currentChildren',
		'expanded'
	],
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #'private - accessing' }
ToExTreeDataWrapper >> childWrappersInterval [

	| idx first last |
	self children ifEmpty: [ ^ 1 to: 0 ].
	idx := self position.

	[
	idx <= dataAccessor size and: [
			(dataAccessor at: idx) parentWrapper = self ] ] whileFalse: [
		idx := idx + 1 ].
	first := idx.
	[
	idx <= dataAccessor size and: [
		(dataAccessor at: idx) parentWrapper notNil and: [
			(dataAccessor at: idx) hasParentWrapper: self ] ] ] whileTrue: [
		idx := idx + 1 ].
	last := idx - 1.
	^ first to: last
]

{ #category : #accessing }
ToExTreeDataWrapper >> children [

	^ currentChildren ifNil: [
		  currentChildren := (childrenHook value: dataItem) collect: [
			                     :aChild |
			                     self class new
				                     dataAccessor: dataAccessor;
				                     parentWrapper: self;
				                     wrapped: aChild;
				                     childrenHook: childrenHook;
				                     yourself ] ]
]

{ #category : #accessing }
ToExTreeDataWrapper >> childrenHook: anObject [

	childrenHook := anObject
]

{ #category : #'expanding-collapsing' }
ToExTreeDataWrapper >> collapse [

	| childrenInterval |
	childrenInterval := self childWrappersInterval.
	childrenInterval do: [ :idx |
		(dataAccessor at: idx) privateExpanded: false ].
	dataAccessor
		removeFrom: childrenInterval first
		to: childrenInterval last.
	expanded := false
]

{ #category : #accessing }
ToExTreeDataWrapper >> dataAccessor [

	^ dataAccessor 
]

{ #category : #accessing }
ToExTreeDataWrapper >> dataAccessor: anObject [

	dataAccessor := anObject
]

{ #category : #'expanding-collapsing' }
ToExTreeDataWrapper >> expand [

	| pos |
	pos := self position.
	self children withIndexDo: [ :w :idx |
		dataAccessor add: w afterIndex: pos + idx - 1 ].
	expanded := true
]

{ #category : #testing }
ToExTreeDataWrapper >> hasChildren [

	^ self children notEmpty
]

{ #category : #'private - testing' }
ToExTreeDataWrapper >> hasParentWrapper: aWrapper [

	parentWrapper ifNil: [ ^ false ].
	parentWrapper = aWrapper ifTrue: [ ^ true ].
	^ parentWrapper hasParentWrapper: aWrapper
]

{ #category : #initialization }
ToExTreeDataWrapper >> initialize [

	super initialize.
	expanded := false.
	childrenHook := [ :d | #(  ) ]
]

{ #category : #testing }
ToExTreeDataWrapper >> isExpanded [ 

	^ expanded
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
ToExTreeDataWrapper >> position [

	| idx |
	idx := 1.
	[ idx <= dataAccessor size and: [ (dataAccessor at: idx) = self ] ]
		whileFalse: [ idx := idx + 1 ].
	^ idx
]

{ #category : #'private - accessing' }
ToExTreeDataWrapper >> privateExpanded: aBoolean [

	expanded := aBoolean
]

{ #category : #'expanding-collapsing' }
ToExTreeDataWrapper >> toggle [

	self isExpanded
		ifTrue: [ self collapse ]
		ifFalse: [ self expand ]
]

{ #category : #accessing }
ToExTreeDataWrapper >> wrapped [

	^ dataItem
]

{ #category : #accessing }
ToExTreeDataWrapper >> wrapped: aDataItem [

	dataItem := aDataItem
]
