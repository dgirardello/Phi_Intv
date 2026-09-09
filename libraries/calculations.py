
def text_to_value(text: str, invert_value: bool = False) -> float:
    normalized = str(text).strip().lower()
    if normalized in ['low', 'medium', 'high']:
        if normalized == 'medium':
            return 50.0
        elif normalized == 'high':
            return 0.0 if invert_value else 100.0
        elif normalized == 'low':
            return 100.0 if invert_value else 0.0
    elif normalized in ['no', 'yes']:
        return 0.0 if normalized == 'no' else 100.0
    else:
        raise ValueError(f"Unrecognized option '{text}'")

def calculate_total_risk(emissions: str, proximity: str, recycling: str, hazardous: str) -> float:
    return (text_to_value(emissions) * 0.4) + (text_to_value(proximity) * 0.35) + (((text_to_value(recycling, invert_value=True) * 0.3) + (text_to_value(hazardous) * 0.7)) * 0.25)

def calculate_waste_management(recycling: str, hazardous: str) -> float:
    return ((text_to_value(recycling) * 0.3) + (text_to_value(hazardous) * 0.7))