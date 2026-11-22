"
I am an element that shows one `ToImage` and fills myself with it. I am the root of the iconic widgets of Toplo: `ToIconicButton` and its subclasses (`ToIconicArrowButton`, `ToIconicAddButton`, `ToIconicRemoveButton`, …), `ToAnimatedIcon` and `ToListSelectionCheckbox`. They are elements whose whole content is an icon, styled by their own skins.

I get my image API from `TToImageHolder`: `image` and `image:` give access to the `ToImage` itself, `innerImage:` changes its source and `innerImageColor:` its color. `innerImage:` on my class side creates me with a source.

## Examples

```
ToIcon exampleSvg.
ToIcon scriptIcons.
```

## Design Rationale

- I hold a `ToImage` rather than being one, so my subclasses can be buttons, checkboxes or animations (with their own state, skin and events) while all images share the conversion and recoloring of `ToImage`.
- I answer `iconImage:`, on both sides, like widgets using `TToLabeledIcon`, so code that sets an icon on a labeled widget also works on me.
- My image matches my size (`TToImageHolder>>image:` sends `matchParent`) and I fit my content. With a form, I take the extent of the form; with an SVG source, give me an extent.

## Usage

1. Widgets and skins create my subclasses, for example `ToAccordionElementSkin` creates a `ToIconicArrowButton` for the header of an accordion. Nothing in Toplo creates a plain `ToIcon`; I am the common part of those widgets.
2. `initialize` gives me an empty `ToImage` through `initializeAsImageHolder`. Clients then set the source with `innerImage:` or `iconImage:`, or replace the whole image with `image:`, which removes the previous one.
3. The skins of my subclasses (`ToIconicButtonSkin` and its subclasses, `ToListSelectionCheckboxSkin`) set the color with `innerImageColor:`. A plain `ToIcon` has a raw skin that sets no color.

I am a mutable element: like any element, use me from the UI process.
"
Class {
	#name : #ToIcon,
	#superclass : #ToElement,
	#traits : 'TToImageHolder',
	#classTraits : 'TToImageHolder classTrait',
	#category : #'Toplo-Widget-Image-Core'
}

{ #category : #examples }
ToIcon class >> exampleSvg [

	<sampleInstance>
	^ (self innerImage: ToMiscellaneousIcons filled_pending_work)
		  extent: 32 @ 32;
		  yourself
]

{ #category : #'t - labeled icon' }
ToIcon class >> iconImage: anInnerImage [

	^ self innerImage: anInnerImage
]

{ #category : #script }
ToIcon class >> scriptIcons [
	"Opens a pane with three icons: an SVG icon, the same icon colored in red with innerImageColor:, and an icon showing a Form, which takes the extent of its form."

	<example>
	| pane |
	pane := ToPane new.
	pane layout: (BlLinearLayout horizontal cellSpacing: 20).
	pane fitContent.
	pane padding: (BlInsets all: 20).
	pane addChildren: {
		self exampleSvg.
		(self exampleSvg
			 innerImageColor: Color red;
			 yourself).
		(self innerImage: (self iconNamed: #delete)) }.
	pane openInSpace.
	^ pane
]

{ #category : #initialization }
ToIcon >> defaultLayout [

	^ BlLinearLayout new 
]

{ #category : #'t - labeled icon' }
ToIcon >> iconImage: anInnerImage [

	self innerImage: anInnerImage
]

{ #category : #initialization }
ToIcon >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self fitContent.

	self initializeAsImageHolder 
]
