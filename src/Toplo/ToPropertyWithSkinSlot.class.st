Class {
	#name : #ToPropertyWithSkinSlot,
	#superclass : #IndexedSlot,
	#instVars : [
		'widgetSkinHandler'
	],
	#category : #'Toplo-Core-Slots'
}

{ #category : #'meta-object-protocol' }
ToPropertyWithSkinSlot >> write: aValue to: anObject [

	| prev r |
	prev := self read: anObject.
	
	" remove previously installed skin change handler"
	widgetSkinHandler ifNotNil: [ :handler |
		anObject removeEventHandler: handler.
		widgetSkinHandler := nil ].
	
	" change the property value actually "
	r := super write: aValue to: anObject.
	
	" value has changed, dispath to the property parent to update the property skin"
	anObject dispatchEvent: (ToPropertyValueChangedEvent new
			 propertyName: self name;
			 current: aValue;
			 previous: prev;
			 yourself).
			
	" prepare and install the handler for the property skin change ( dispatched from the parent )"
	widgetSkinHandler := BlEventHandler
		                     on: ToElementSkinChangedEvent
		                     do: [ :evt |
			                     anObject dispatchEvent:
				                     (ToPropertySkinChangedEvent new
					                      propertyName: self name;
					                      current: aValue;
					                      previous: prev;
					                      yourself) ].
	anObject addEventHandler: widgetSkinHandler.

	^ r
]
