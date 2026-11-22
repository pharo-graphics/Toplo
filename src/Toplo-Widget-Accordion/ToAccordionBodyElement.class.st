"
I am the body of a `ToAccordionElement`: the part shown when the accordion is expanded and hidden when it is collapsed. I keep a builder block and build my content from it lazily, when I am shown.

## Examples

```
ToAccordionBodyElement exampleExpanded
```

## Design Rationale

- My children live in an inner `content` element, not directly in me. Collapsing makes `content` gone (`BlVisibility gone`), so it takes no room in the layout while its children are kept. `ToAccordionBodyElementSkin` puts the padding on `content`, not on me, so a collapsed body has no height.
- `switchExpanded` runs the builder only when nothing has been built yet or when the content is not preserved. With preserved content (the default), the user finds the body as they left it, for example with the text they typed.
- `builder:` marks me as not built, so the next expansion uses the new block.

## Usage

1. `ToAccordionElement>>newBody` creates me when the accordion is initialized; the accordion keeps me and answers me with `body`.
2. The accordion forwards `bodyBuilder:` to my `builder:` and `preserveBody:` to my `preservedContent:`.
3. When the checked state of the accordion changes, `ToAccordionElement>>privateExpanded:` sends me `switchExpanded` or `switchCollapsed`.

I am stateful: what `switchExpanded` does depends on whether I was already built and on `preservedContent:`.

## Invariants and Assumptions

- The builder receives `content`, never me: it adds children to that element and may assume it is empty, since I remove its children before running the builder.
"
Class {
	#name : #ToAccordionBodyElement,
	#superclass : #ToElement,
	#instVars : [
		'builder',
		'content',
		'preservedContent',
		'isBuilt'
	],
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #examples }
ToAccordionBodyElement class >> exampleExpanded [

	<sampleInstance>
	^ self new
		  builder: [ :content | content addChild: (ToLabel text: 'Body content') ];
		  switchExpanded;
		  yourself
]

{ #category : #accessing }
ToAccordionBodyElement >> builder: aValuable [
	"With content as argument"

	isBuilt := false.
	builder := aValuable 
]

{ #category : #accessing }
ToAccordionBodyElement >> content [ 

	^ content
]

{ #category : #initialization }
ToAccordionBodyElement >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToAccordionBodyElement >> initialize [ 

	super initialize.
	isBuilt := false.
	preservedContent := true.
	self initializeContent
]

{ #category : #initialization }
ToAccordionBodyElement >> initializeContent [

	content := ToElement new
		           withNullSkin;
		           background: BlBackground transparent;
		           layout: BlLinearLayout vertical;
		           constraintsDo: [ :c |
			           c vertical fitContent.
			           c horizontal matchParent.
			           c linear vertical alignCenter ];
		           yourself.
	content visibility: BlVisibility gone.
	self addChild: content.
]

{ #category : #'instance creation' }
ToAccordionBodyElement >> newRawSkin [ 

	^ ToAccordionBodyElementSkin new
]

{ #category : #accessing }
ToAccordionBodyElement >> preservedContent: aBoolean [

	preservedContent := aBoolean
]

{ #category : #'expanding-collapsing' }
ToAccordionBodyElement >> switchCollapsed [

	preservedContent ifFalse: [ content removeChildren ].
	content visibility: BlVisibility gone
]

{ #category : #'expanding-collapsing' }
ToAccordionBodyElement >> switchExpanded [

	(isBuilt and: [ preservedContent ]) ifFalse: [
		content removeChildren.
		builder ifNotNil: [ builder value: content ].
		isBuilt := true ].
	content visibility: BlVisibility visible
]
