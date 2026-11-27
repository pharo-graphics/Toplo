"
I am a placeholder layer that shows a `ToEmpty`, an image with a label telling that there is nothing to show or that something is awaited. See `ToPlaceholderLayer` for how placeholders are shown.

`withEmpty:` creates me with a given `ToEmpty`; `empty:` replaces it. The default one is `ToEmpty box`.

## Examples

```
ToEmptyPlaceholderLayer exampleDefault
```

## Usage

`ToBasicListElement>>placeholderClass` answers me, so lists show me when they are empty. A client can also create me with `withEmpty:` and attach me to a pane with `attachToParent:`, for example to show that its content is being computed.

I prevent mouse events, so that the pointer reaches the element under me.
"
Class {
	#name : #ToEmptyPlaceholderLayer,
	#superclass : #ToPlaceholderLayer,
	#instVars : [
		'empty'
	],
	#category : #'Toplo-Widget-Pane-Utils'
}

{ #category : #examples }
ToEmptyPlaceholderLayer class >> exampleDefault [
	"A pane covered by a layer with an empty-state picture and a label."

	<example>
	| pane |
	pane := ToPane new matchParent.
	self instanceWaiting attachToParent: pane.
	^ pane openInSpace
]

{ #category : #instances }
ToEmptyPlaceholderLayer class >> instanceWaiting [

	<sampleInstance>
	^ self withEmpty: (ToEmpty waiting labelText: 'Waiting...')
]

{ #category : #'instance creation' }
ToEmptyPlaceholderLayer class >> withEmpty: anEmpty [

	^ self new
		  empty: anEmpty;
		  yourself
]

{ #category : #accessing }
ToEmptyPlaceholderLayer >> empty [ 

	^ empty
]

{ #category : #accessing }
ToEmptyPlaceholderLayer >> empty: anEmpty [

	empty ifNotNil: [ empty removeFromParent ].
	empty := anEmpty.
	empty ifNotNil: [ self addChild: empty ].
	self requestNewSkin
]

{ #category : #initialization }
ToEmptyPlaceholderLayer >> initialize [

	super initialize.
	self empty: ToEmpty box.
	self layout alignCenter.
	self preventMouseEvents.
]
