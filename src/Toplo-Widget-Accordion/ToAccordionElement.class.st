"
I am an accordion: a header that stays visible and a body that the user shows or hides by clicking. I let a UI keep secondary content folded away until it is needed, for example a stack of sections in a pane or a list of collapsible items.

I am made of a `ToAccordionHeaderElement` and a `ToAccordionBodyElement`. Clients fill them with blocks: `headerBuilder:` receives the header content element, `bodyBuilder:` the body content element. `expand`, `collapse` and `isExpanded` drive and query my state, and `ToAccordionElementSkin` turns the expand arrow of my header accordingly.

## Examples

```
ToAccordionElement exampleWithLabel.
ToAccordionElement exampleExpanded.
ToAccordionElement scriptAccordionsInPane.
```

## Design Rationale

- My expanded state is my checked state: I use `TToCheckable`, and `isExpanded:` is `checked:`. A click toggles me (`newClickAction:` answers a check action), and my `ToCheckableCheckEvent` handler shows or hides the body. Reusing the checkable machinery lets me work in a `ToCheckableGroupPane` without extra code: with the default group exactly one accordion of the group is expanded, with `group withWeakCheckingStrategy` at most one.
- I use `TToListItem`, so I can also be an item of a `ToCheckableListElement`.
- My body is built lazily: the body block runs the first time I am expanded, not when it is set. A collapsed accordion with a heavy body (an editor, nested accordions) costs nothing until it is opened. By default the built content is kept and only hidden when I collapse; `preserveBody: false` discards it on collapse and runs the block again at the next expansion, for content that must be fresh each time.
- My header has three areas: the expand icon, the content filled by `headerBuilder:`, and an extra area filled by `headerExtraBuilder:` for small actions such as an iconic button. `expandIconAtStart: false` moves the icon to the end, next to the extra area.

## Usage

1. A client creates me with `new`. I start collapsed, filling the width of my parent and fitting the height of my content. `ToAccordionElement>>initializeHeader` and `ToAccordionElement>>initializeBody` create my parts through `newHeader` and `newBody`; `header` and `body` answer them.
2. The client sends `headerBuilder:` and `bodyBuilder:`, optionally `headerExtraBuilder:`, `expandIconAtStart:` and `preserveBody:`, then adds me to a container (`ToPane`, `ToCheckableGroupPane`, `ToCheckableListElement`).
3. The user clicks my header, or the client sends `expand`, `collapse` or `isExpanded:`. `isExpanded` and `isCollapsed` answer my state.

I am a mutable Bloc element: like any element, use me from the UI process. The `#borderless` stamp removes my border.

## Implementation Notes

- `headerBuilder:` runs its block at once on the header content, while `bodyBuilder:` only stores its block. Do not expect body content before the first `expand`.
- The click handler is installed on me as a whole, so a click inside my body toggles me too, including a click on the header of a nested accordion, which collapses the outer one. This is a known issue.
"
Class {
	#name : #ToAccordionElement,
	#superclass : #ToElement,
	#traits : 'TToCheckable + TToListItem',
	#classTraits : 'TToCheckable classTrait + TToListItem classTrait',
	#instVars : [
		'header',
		'body'
	],
	#category : #'Toplo-Widget-Accordion'
}

{ #category : #examples }
ToAccordionElement class >> demoAccordionWithRebuiltBody [
	"An accordion whose body is not preserved: its builder runs again each time it is expanded, as the label shows."

	<sampleInstance>
	| count |
	count := 0.
	^ self new
		  headerBuilder: [ :header | header addChild: (ToLabel text: 'An accordion whose body not preserved but rebuilt each time') ];
		  bodyBuilder: [ :body |
			  count := count + 1.
			  body addChild: (ToLabel text: ('Built {1} time(s)' format: { count })) ];
		  preserveBody: false;
		  yourself
]

{ #category : #examples }
ToAccordionElement class >> demoAccordionWithSearchButton [
	"An accordion with its expand icon at the end and a search button in the extra area of its header."

	<sampleInstance>
	| searchIcon |
	searchIcon := ToImage inner: (ToAntDesignIconProvider innerImageNamed: 'outlined_search').
	searchIcon extent: 18 @ 18.
	^ self exampleWithLabel
		  expandIconAtStart: false;
		  headerExtraBuilder: [ :extra |
			  extra addChild: (ToButton new
				   icon: searchIcon;
				   addStamp: #iconic;
				   addStamp: #borderless;
				   yourself) ];
		  yourself
]

{ #category : #examples }
ToAccordionElement class >> exampleExpanded [

	<sampleInstance>
	^ self exampleWithLabel
		  expand;
		  yourself
]

{ #category : #examples }
ToAccordionElement class >> exampleWithLabel [

	<sampleInstance>
	^ self new
		  headerBuilder: [ :header | header addChild: (ToLabel text: 'Header of accordion') ];
		  bodyBuilder: [ :body | body addChild: (ToLabel text: 'The body of the accordion is built the first time I am expanded') ];
		  yourself
]

{ #category : #script }
ToAccordionElement class >> scriptAccordionsInPane [
	"Three accordions stacked in a pane: a default one, one with its expand icon at the end and a search button in the extra area of its header, and one whose body is rebuilt each time it is expanded."

	<example>
	| pane |
	pane := ToPane new.
	pane layout: BlLinearLayout vertical.
	pane hMatchParent.
	pane vFitContent.
	pane addChild: self exampleWithLabel.
	pane addChild: self demoAccordionWithSearchButton.
	pane addChild: self demoAccordionWithRebuiltBody.
	pane openInSpace.
	^ pane
]

{ #category : #configuration }
ToAccordionElement >> applyConfiguration [ 

	super applyConfiguration.
	self applyConfigurationAsListItem
]

{ #category : #accessing }
ToAccordionElement >> body [

	^ body
]

{ #category : #accessing }
ToAccordionElement >> bodyBuilder: aValuable [
	"With a body content as argument"
	
	body builder: aValuable
]

{ #category : #'expanding-collapsing' }
ToAccordionElement >> collapse [

	self isExpanded: false
]

{ #category : #'expanding-collapsing' }
ToAccordionElement >> expand [

	self isExpanded: true
]

{ #category : #accessing }
ToAccordionElement >> expandIconAtStart: aBoolean [

	header expandIconAtStart: aBoolean
]

{ #category : #accessing }
ToAccordionElement >> header [

	^ header
]

{ #category : #accessing }
ToAccordionElement >> headerBuilder: aValuable [
	"With an header as argument"
	
	header builder: aValuable
]

{ #category : #accessing }
ToAccordionElement >> headerExtraBuilder: aValuable [

	header headerExtraBuilder: aValuable
]

{ #category : #initialization }
ToAccordionElement >> initialize [

	super initialize.
	self layout: BlLinearLayout vertical.
	self hMatchParent.
	self vFitContent.

	self initializeAsCheckable.
	self initializeHeader.
	self initializeBody.

	self
		addEventHandlerOn: ToCheckableCheckEvent
		do: [self privateExpanded: self isChecked ]
]

{ #category : #initialization }
ToAccordionElement >> initializeBody [

	body := self newBody.
	body hMatchParent.
	body vFitContent.
	self addChild: body
]

{ #category : #initialization }
ToAccordionElement >> initializeHeader [

	header := self newHeader.
	self addChild: header
]

{ #category : #testing }
ToAccordionElement >> isCollapsed [ 
	
	^ self isExpanded not
]

{ #category : #testing }
ToAccordionElement >> isCollapsed: aBoolean [

	self isExpanded: aBoolean not
]

{ #category : #testing }
ToAccordionElement >> isExpanded [

	^ self isChecked
]

{ #category : #accessing }
ToAccordionElement >> isExpanded: aBoolean [

	self checked: aBoolean
]

{ #category : #initialization }
ToAccordionElement >> newBody [

	^ ToAccordionBodyElement new
]

{ #category : #'t - element with action' }
ToAccordionElement >> newClickAction: aValuable [

	^ self newCheckAction: aValuable
]

{ #category : #'instance creation' }
ToAccordionElement >> newHeader [ 

	^  ToAccordionHeaderElement new
]

{ #category : #skin }
ToAccordionElement >> newRawSkin [

	^ ToAccordionElementSkin new
]

{ #category : #accessing }
ToAccordionElement >> preserveBody: aBoolean [

	body preservedContent: aBoolean
]

{ #category : #testing }
ToAccordionElement >> privateExpanded: aBoolean [

	aBoolean
		ifTrue: [ body switchExpanded ]
		ifFalse: [ body switchCollapsed ]
]

{ #category : #testing }
ToAccordionElement >> privateSwitchExpanded [

	self isExpanded: self isExpanded not
]
