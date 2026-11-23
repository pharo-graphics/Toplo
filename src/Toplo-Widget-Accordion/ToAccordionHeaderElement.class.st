"
I am the header of a `ToAccordionElement`: the row that stays visible when the accordion is collapsed. I lay out three areas in a `ToTripletElement`: the expand icon, the content, and an extra area for small actions.

## Examples

```
ToAccordionHeaderElement exampleWithLabel
```

## Design Rationale

- `builder:` runs its block at once on my content, after removing the previous children. The body builder runs lazily, but I am always visible, so there is nothing to defer.
- The position of the icon is a configuration: `expandIconAtStart:` records the choice and requests a configuration, and `applyConfiguration` rearranges the triplet. With the icon at the start, the icon is the start element of the triplet and the extra area its end element. Otherwise both go into one end element, extra area first.
- The end side of the triplet is flexible and my content fits its children, so the extra area and an icon at the end are pushed to the right edge.

## Usage

1. `ToAccordionElement>>newHeader` creates me when the accordion is initialized; the accordion keeps me and answers me with `header`.
2. The accordion forwards `headerBuilder:` to my `builder:`, and `headerExtraBuilder:` and `expandIconAtStart:` to mine.
3. `ToAccordionElementSkin` gives me my arrow with `icon:` when it is installed, and turns it with `icon beDown` and `icon beRight` when the accordion is expanded or collapsed.

I live as long as my accordion; I am not meant to be moved to another one.

## Implementation Notes

- `icon` answers the first child of the icon container. It fails before my skin is installed, since the arrow is put there by `ToAccordionElementSkin`.
"
Class {
	#name : #ToAccordionHeaderElement,
	#superclass : #ToElement,
	#instVars : [
		'iconContainer',
		'content',
		'expandIconAtStart',
		'triplet',
		'extraContainer'
	],
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #examples }
ToAccordionHeaderElement class >> exampleWithLabel [

	<script>
	| inst |
	inst := self new.
	inst builder: [ :header | header addChild: (ToLabel text: 'header') ].
	inst openInSpace.
	^ inst
]

{ #category : #accessing }
ToAccordionHeaderElement >> applyConfiguration [

	super applyConfiguration.
	expandIconAtStart
		ifTrue: [
				triplet startElement = iconContainer ifFalse: [
					triplet startElement: iconContainer ].
				triplet endElement = extraContainer ifFalse: [
					triplet endElement: extraContainer ] ]
		ifFalse: [
				| end |
				triplet startElement: nil.
				triplet endElement: nil.
				extraContainer removeFromParent.
				iconContainer removeFromParent.
				end := ToElement new
					       fitContent;
					       layout: BlLinearLayout horizontal;
					       yourself.
				end addChild: extraContainer.
				end addChild: iconContainer.
				end layout cellSpacing: 5.
				triplet endElement: end ]
]

{ #category : #accessing }
ToAccordionHeaderElement >> builder: aValuable [
	"With an header as argument"

	content removeChildren.
	aValuable value: content
]

{ #category : #accessing }
ToAccordionHeaderElement >> content [ 

	^ content
]

{ #category : #accessing }
ToAccordionHeaderElement >> expandIconAtStart: aBoolean [

	expandIconAtStart = aBoolean ifTrue: [ ^ self ].
	expandIconAtStart := aBoolean.
	self requestConfiguration 
]

{ #category : #accessing }
ToAccordionHeaderElement >> headerExtraBuilder: aValuable [

	
	aValuable value: extraContainer
]

{ #category : #accessing }
ToAccordionHeaderElement >> icon [

	^ iconContainer firstChild
]

{ #category : #accessing }
ToAccordionHeaderElement >> icon: aToImage [

	iconContainer removeChildren.
	iconContainer addChild: aToImage	
]

{ #category : #initialization }
ToAccordionHeaderElement >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self hMatchParent.
	self vFitContent.
	triplet := ToTripletElement new
		           hMatchParent;
		           vFitContent;
		           yourself.
	content := ToElement new.
	content layout: BlLinearLayout horizontal.
	content fitContent.
	triplet middleElement: content.
	triplet startFlexible: false.
	triplet endFlexible: true.

	iconContainer := ToElement new.
	iconContainer fitContent.
	iconContainer constraintsDo: [ :c | c linear vertical alignCenter ].
	extraContainer := ToElement new.
	extraContainer fitContent.
	extraContainer constraintsDo: [ :c | c linear vertical alignCenter ].
	self constraintsDo: [ :c | c linear vertical alignCenter ].
	self addChild: triplet.
	self expandIconAtStart: true
]

{ #category : #initialization }
ToAccordionHeaderElement >> newRawSkin [

	^ ToAccordionHeaderElementSkin new
]
