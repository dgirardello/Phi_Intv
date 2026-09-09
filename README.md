# Environmental Impact Risk Calculator - Test Automation Suite

A robust automated testing suite developed with **Robot Framework** and **SeleniumLibrary** for the functional, mathematical, and boundary validation of the Environmental Impact Risk Calculator application.

---

## Features Tested
- **UI Component Interactions**: Dynamic handling of Radix UI elements (nested screen-reader `<button role="radio">` components, custom indicator states, and toggle controls).
- **Mathematical Factor Validation**: Full verification of weighted calculations:
  - **CO₂ Emissions**: 40%
  - **Proximity to Protected Areas**: 35%
  - **Waste Management Sub-factor**: 25% (comprising 30% inverted Recycling Efficiency + 70% Hazardous Waste Handling).
- **Risk Level Boundaries**: Dynamic evaluation of risk tier mapping:
  - **Low Risk**: $< 30\%$
  - **Moderate Risk**: $30\% - 50\%$
  - **High Risk**: $> 50\%$
- **Data-Driven / Parameterized Testing**: Matrix test execution across comprehensive factor permutations.

---

## Project Structure

```text
├── config/
│   └── env.py                              # Environment base URLs and global timeouts
├── libraries/
│   └── calculations.py                     # Python mathematical baseline logic
├── resources/
│   ├── common_keywords.robot               # Browser lifecycle & global utilities
│   └── pages/
│       ├── login_page.robot                # Login Page Object Model
│       └── risk_calculator_page.robot      # Risk Calculator Page Object Model
├── results/                                # Generated execution outputs, logs, and reports
├── tests/
│   ├── risk_calculator_c02_emmissions_tests.robot
│   └── ...
├── requirements.txt                        # Python dependencies
└── README.md
```

---

## Prerequisites & Installation

### 1. System Requirements
- **Python**: 3.10+ (tested up to Python 3.14)
- **Web Browser**: Google Chrome (or Chromium-based browser)
- **Driver**: Compatible ChromeDriver matching your local Chrome version (or managed automatically via `selenium` 4.x / `webdriver-manager`)

### 2. Clone the Repository
```bash
git clone <repository-url>
cd <project-folder>
```

### 3. Set Up Virtual Environment

#### On Windows:
```powershell
python -m venv venv
venv\Scripts\activate
```

#### On macOS / Linux:
```bash
python3 -m venv venv
source venv/bin/activate
```

### 4. Install Dependencies
Install all required libraries using pip:

```bash
pip install -r requirements.txt
```

#### Example `requirements.txt`:
```text
robotframework>=7.0
robotframework-seleniumlibrary>=6.2.0
selenium>=4.20.0
```

---

## Running the Tests

Ensure your virtual environment is active before running tests.

### 1. Run All Tests
Executes the full test suite and routes all test artifacts (`log.html`, `report.html`, and `output.xml`) into the `results/` folder:

```bash
robot --outputdir results tests/
```

### 2. Run a Specific Test Suite
```bash
robot --outputdir results tests/risk_calculator_c02_emmissions_tests.robot
```

### 3. Run by Test Case Name
```bash
robot --outputdir results -t "PI-5.1: Verify Standalone CO2 Emissions Weighting (Weight: 40%)" tests/
```

### 4. Run Tests by Tags
You can filter tests using metadata tags (e.g., `Emissions`, `Calculation`, `High`):

```bash
# Run tests with the 'Emissions' tag
robot --outputdir results --include Emissions tests/

# Run tests with both 'Calculation' AND 'High'
robot --outputdir results --include CalculationANDHigh tests/
```

### 5. Running in Headless Mode
To run headless in CI/CD pipelines, pass or override the Chrome option flags in your settings/command:

```bash
robot --outputdir results --variable BROWSER:headlesschrome tests/
```

---

## Viewing Test Results

After test execution, Robot Framework generates three files inside the `results/` directory:
- **`report.html`**: High-level statistical overview, execution status, and pass/fail metrics.
- **`log.html`**: Comprehensive step-by-step keyword execution logs with runtime details and DOM interactions.
- **`output.xml`**: Machine-readable XML format for CI/CD integration (e.g., Jenkins, GitHub Actions).

Open the report or log in any standard web browser:
```bash
# Windows
start results/log.html

# macOS
open results/log.html

# Linux
xdg-open results/log.html
```

---

## Troubleshooting & Key Notes

1. **Radix UI `sr-only` Elements (`ElementClickInterceptedException`)**:
   - The radio controls inside the application render hidden `<button role="radio">` tags beneath custom SVG/DIV indicators. Locators in `risk_calculator_page.robot` target the enclosing `label:has(...)` to avoid click interception.
2. **Dynamic Percentage Formatting**:
   - The UI outputs percentages with trailing `%` signs (e.g., `9.0%`). Custom keywords clean the strings using `String.Remove String` before running numerical assertions (`Should Be Equal As Numbers`).
3. **Keyword Namespace Collision**:
   - Explicit prefixes like `calculations.Calculate Total Risk` ensure clear distinction between local Robot Framework user keywords and Python helper library calculations.
