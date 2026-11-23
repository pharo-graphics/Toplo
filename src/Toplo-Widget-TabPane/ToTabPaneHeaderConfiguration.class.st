"
I am the configuration of a `ToTabPaneHeaderElement`: I give the header its size, translate its alignment into flexible sides, and make the tab group fill the header or fit its tabs.

## Examples

```
ToTabPaneElement exampleTabs
```

## Design Rationale

- The alignment is a matter of fillers: at the start only the end side is flexible, in the middle both are, and without alignment none is, so the tab group takes the whole width.

## Usage

`ToTabPaneHeaderElement>>newToConfiguration` creates me. The header applies me when it needs a configuration. `matchParentMode:` is set by the header, in compact mode.

## Implementation Notes

- When there is no flexible side and the tab group is not flowable, I scroll the selected tab into view after the next layout.
"
Class {
	#name : #ToTabPaneHeaderConfiguration,
	#superclass : #ToTripletContainerConfiguration,
	#instVars : [
		'matchParentMode'
	],
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #hook }
ToTabPaneHeaderConfiguration >> applyOn: anElement [

	super applyOn: anElement.
	anElement isHorizontal
		ifTrue: [
				anElement hMatchParent.
				anElement vFitContent ]
		ifFalse: [
				anElement vMatchParent.
				anElement hFitContent ].
	self configureAlignmentIn: anElement
]

{ #category : #hook }
ToTabPaneHeaderConfiguration >> configureAlignmentIn: anElement [

	anElement alignment ifNull: [
			anElement startFlexible: false.
			anElement endFlexible: false ].
	anElement alignment = BlElementAlignment start ifTrue: [
			anElement startFlexible: false.
			anElement endFlexible: true  ].
	anElement alignment = BlElementAlignment end ifTrue: [
			anElement startFlexible: true.
			anElement endFlexible: false  ].
	anElement alignment = BlElementAlignment middle ifTrue: [
			anElement startFlexible: true.
			anElement endFlexible: true  ].

	self configureTabGroupIn: anElement
]

{ #category : #hook }
ToTabPaneHeaderConfiguration >> configureTabGroupIn: anElement [

	| tabGroup |
	tabGroup := anElement tabGroup.
	(anElement isStartFlexible or: [ anElement isEndFlexible ]) ifTrue: [
			tabGroup fitContent.
			^ self ].

	anElement isHorizontal
		ifTrue: [
				tabGroup hMatchParent.
				tabGroup vFitContent ]
		ifFalse: [
				tabGroup vMatchParent.
				tabGroup hFitContent ].
	tabGroup isFlowable ifTrue: [ ^ self ].

	matchParentMode
		ifTrue: [ self switchToMatchParentIn: anElement ]
		ifFalse: [ self switchToFitContentIn: anElement ].

	tabGroup selectionModel selectedIndexesDo: [ :idx |
			anElement whenLayoutedDoOnce: [
				tabGroup selecter scrollTowardStartToDataSourcePosition: idx ] ]
]

{ #category : #initialization }
ToTabPaneHeaderConfiguration >> initialize [ 

	super initialize.
	matchParentMode := true
]

{ #category : #accessing }
ToTabPaneHeaderConfiguration >> matchParentMode [

	^ matchParentMode
]

{ #category : #accessing }
ToTabPaneHeaderConfiguration >> matchParentMode: aBoolean [

	matchParentMode := aBoolean
]

{ #category : #'private - layout managing' }
ToTabPaneHeaderConfiguration >> switchToFitContentIn: anHeaderElement [

	anHeaderElement trackElement
		allParentsUpTo: anHeaderElement tabGroup
		do: [ :p |
				anHeaderElement isHorizontal
					ifTrue: [ p hFitContent ]
					ifFalse: [ p vFitContent ] ]
]

{ #category : #'private - layout managing' }
ToTabPaneHeaderConfiguration >> switchToMatchParentIn: anHeaderElement [

	anHeaderElement trackElement
		allParentsUpTo: anHeaderElement tabGroup
		do: [ :p |
				anHeaderElement isHorizontal
					ifTrue: [ p hMatchParent ]
					ifFalse: [ p vMatchParent ] ]
]
