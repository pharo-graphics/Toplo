"
I am the common part of the requests a `ToDivider` dispatches before it moves. A listener that sends me `deny` stops the action I announce. I carry the Bloc drag event I come from, as `sourceEvent`.

## Examples

```
ToPaneDivider exampleDefault
```

## Design Rationale

- A request is an event like the others, so that any listener can refuse a move without knowing who started it. The action runs only after the dispatch, and only if nobody denied me (`ToAuthorisationRequestEvent`).

## Usage

1. `ToDividerEventHandler` creates my subclasses with the action to run, and sends them to the divider with `dispatchRequest:`.
2. Listeners on the divider may send `deny`. Nothing in Toplo denies me.

Each instance is used for one request.
"
Class {
	#name : #ToDividerRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Pane-Events'
}

{ #category : #accessing }
ToDividerRequestEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToDividerRequestEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
